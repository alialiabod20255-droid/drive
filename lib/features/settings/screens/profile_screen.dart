import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('settings'))),
      body: const Center(child: Text('Profile')),
    );
  }
}
