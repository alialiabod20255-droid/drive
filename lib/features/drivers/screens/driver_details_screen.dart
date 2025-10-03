import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';

class DriverDetailsScreen extends StatelessWidget {
  final String driverId;
  const DriverDetailsScreen({super.key, required this.driverId});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('drivers'))),
      body: const Center(child: Text('Driver details')),
    );
  }
}
