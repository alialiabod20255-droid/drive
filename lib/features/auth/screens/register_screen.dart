import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/common/custom_button.dart';
import '../../../../widgets/common/custom_textfield.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  String _role = 'employee';

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('register'))),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(controller: _name, label: l10n.t('name'), validator: (v) => v != null && v.isNotEmpty ? null : l10n.t('name')),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _email, label: l10n.t('email'), keyboardType: TextInputType.emailAddress, validator: (v) => v != null && v.contains('@') ? null : l10n.t('email')),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _phone, label: l10n.t('phone'), keyboardType: TextInputType.phone, validator: (v) => v != null && v.length >= 8 ? null : l10n.t('phone')),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _password, label: l10n.t('password'), obscure: true, validator: (v) => v != null && v.length >= 6 ? null : l10n.t('password')),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _role,
                    decoration: InputDecoration(labelText: l10n.t('role')),
                    items: [
                      DropdownMenuItem(value: 'admin', child: Text(l10n.t('admin'))),
                      DropdownMenuItem(value: 'employee', child: Text(l10n.t('employee'))),
                      DropdownMenuItem(value: 'driver', child: Text(l10n.t('driver'))),
                    ],
                    onChanged: (v) => setState(() => _role = v ?? 'employee'),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    label: l10n.t('register'),
                    loading: auth.loading,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await auth.register(
                          name: _name.text.trim(),
                          email: _email.text.trim(),
                          phone: _phone.text.trim(),
                          password: _password.text,
                          role: _role,
                        );
                        if (mounted && auth.error == null) Navigator.of(context).pop();
                        if (auth.error != null) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(auth.error!)));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
