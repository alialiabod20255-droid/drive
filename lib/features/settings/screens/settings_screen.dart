import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('settings'))),
      body: ListView(
        children: [
          ListTile(title: Text(l10n.t('language')), onTap: () => Navigator.of(context).pushNamed('/language')),
          ListTile(title: Text(l10n.t('theme')), onTap: () => Navigator.of(context).pushNamed('/theme')),
          ListTile(title: const Text('Profile'), onTap: () => Navigator.of(context).pushNamed('/profile')),
        ],
      ),
    );
  }
}
