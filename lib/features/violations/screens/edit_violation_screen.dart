import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/common/custom_button.dart';
import '../../../../widgets/common/custom_textfield.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';

class EditViolationScreen extends StatefulWidget {
  final String violationId;
  const EditViolationScreen({super.key, required this.violationId});

  @override
  State<EditViolationScreen> createState() => _EditViolationScreenState();
}

class _EditViolationScreenState extends State<EditViolationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _type = TextEditingController();
  final _points = TextEditingController();

  @override
  void dispose() {
    _type.dispose();
    _points.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('save'))),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection(AppConstants.violationsCollection).doc(widget.violationId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final v = snapshot.data!.data()!;
          _type.text = v['type'] ?? '';
          _points.text = (v['points_deducted'] ?? 0).toString();
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(controller: _type, label: 'Type'),
                      const SizedBox(height: 12),
                      CustomTextField(controller: _points, label: 'Points', keyboardType: TextInputType.number),
                      const SizedBox(height: 20),
                      CustomButton(
                        label: l10n.t('save'),
                        onPressed: () async {
                          await FirebaseFirestore.instance.collection(AppConstants.violationsCollection).doc(widget.violationId).update({
                            'type': _type.text.trim(),
                            'points_deducted': int.tryParse(_points.text) ?? 0,
                          });
                          if (mounted) Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
