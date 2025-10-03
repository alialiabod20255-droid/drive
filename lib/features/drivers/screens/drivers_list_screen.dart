import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../providers/drivers_provider.dart';
import '../../../../widgets/common/custom_card.dart';

class DriversListScreen extends StatelessWidget {
  const DriversListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final provider = context.watch<DriversProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('drivers'))),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('drivers').orderBy('created_at', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) return Center(child: Text(l10n.t('drivers')));
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final d = docs[i].data();
              return CustomCard(
                child: ListTile(
                  title: Text(d['name'] ?? ''),
                  subtitle: Text('${d['license_number'] ?? ''} • ${d['points'] ?? 0}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
