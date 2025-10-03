import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../widgets/common/custom_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('dashboard'))),
      body: LayoutBuilder(builder: (context, c) {
        final isWide = c.maxWidth > 700;
        return GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: isWide ? 3 : 1,
          childAspectRatio: isWide ? 3 : 2.2,
          children: const [
            CustomCard(child: ListTile(title: Text('Total Drivers'), subtitle: Text('—'))),
            CustomCard(child: ListTile(title: Text('Today Violations'), subtitle: Text('—'))),
            CustomCard(child: ListTile(title: Text('Avg Points'), subtitle: Text('—'))),
          ],
        );
      }),
    );
  }
}
