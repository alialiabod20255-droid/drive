import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';

class ViolationDetailsScreen extends StatelessWidget {
  final String violationId;
  const ViolationDetailsScreen({super.key, required this.violationId});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('violations'))),
      body: const Center(child: Text('Violation details')),
    );
  }
}
