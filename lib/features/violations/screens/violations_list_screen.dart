import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizationS.dart';
import '../../../../widgets/common/custom_card.dart';

class ViolationsListScreen extends StatelessWidget {
  const ViolationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('violations'))),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('violations').orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) return Center(child: Text(l10n.t('violations')));
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final v = docs[i].data();
              return CustomCard(
                child: ListTile(
                  title: Text(v['type'] ?? ''),
                  subtitle: Text('${v['date'] ?? ''} • -${v['points_deducted'] ?? 0}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
