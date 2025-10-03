import 'package:flutter/material.dart';
import 'package:traffic_violations_app/core/localization/app_localizations.dart';

class ExportPdfScreen extends StatelessWidget {
  const ExportPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('reports'))),
      body: const Center(child: Text('Export PDF')),
    );
  }
}
