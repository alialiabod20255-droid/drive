import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../providers/settings_provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('language'))),
      body: Column(
        children: [
          RadioListTile<Locale>(
            value: const Locale('ar'),
            groupValue: settings.locale,
            onChanged: (v) => settings.setLocale(v!),
            title: const Text('العربية'),
          ),
          RadioListTile<Locale>(
            value: const Locale('en'),
            groupValue: settings.locale,
            onChanged: (v) => settings.setLocale(v!),
            title: const Text('English'),
          ),
        ],
      ),
    );
  }
}
