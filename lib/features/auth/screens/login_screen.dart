import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic_violations_app/core/localization/app_localizations.dart';
import 'package:traffic_violations_app/features/auth/providers/auth_provider.dart';
import 'package:traffic_violations_app/features/dashboard/screens/navigation_screen.dart';
import 'package:traffic_violations_app/widgets/common/custom_button.dart';
import 'package:traffic_violations_app/widgets/common/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final auth = context.watch<AuthProvider>();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('login'))),
      body: LayoutBuilder(builder: (context, c) {
        final isWide = c.maxWidth > 600;
        final content = Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _email,
                label: l10n.t('email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v != null && v.contains('@') ? null : l10n.t('email'),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _password,
                label: l10n.t('password'),
                obscure: true,
                validator: (v) => v != null && v.length >= 6 ? null : l10n.t('password'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                label: l10n.t('login'),
                loading: auth.loading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await auth.loginWithEmail(_email.text.trim(), _password.text);
                    if (mounted && auth.error == null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const NavigationScreen()),
                      );
                    } else if (auth.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(auth.error!)));
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/forgot'),
                child: Text(l10n.t('forgot_password')),
              )
            ],
          ),
        );
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isWide ? 480 : 600),
              child: content,
            ),
          ),
        );
      }),
    );
  }
}
