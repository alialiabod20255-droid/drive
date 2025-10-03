import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('reports'))),
      body: const Center(child: Text('Stats')),
    );
  }
}
