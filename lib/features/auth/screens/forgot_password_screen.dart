import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic_violations_app/core/localization/app_localizations.dart';
import 'package:traffic_violations_app/features/auth/providers/auth_provider.dart';
import 'package:traffic_violations_app/widgets/common/custom_button.dart';
import 'package:traffic_violations_app/widgets/common/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('forgot_password'))),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(controller: _email, label: l10n.t('email'), keyboardType: TextInputType.emailAddress, validator: (v) => v != null && v.contains('@') ? null : l10n.t('email')),
                  const SizedBox(height: 20),
                  CustomButton(
                    label: l10n.t('save'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await auth.resetPassword(_email.text.trim());
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
