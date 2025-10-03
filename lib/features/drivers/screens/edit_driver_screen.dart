import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traffic_violations_app/core/constants/app_constants.dart';
import 'package:traffic_violations_app/core/localization/app_localizations.dart';
import 'package:traffic_violations_app/widgets/common/custom_button.dart';
import 'package:traffic_violations_app/widgets/common/custom_textfield.dart';

class EditDriverScreen extends StatefulWidget {
  final String driverId;
  const EditDriverScreen({super.key, required this.driverId});

  @override
  State<EditDriverScreen> createState() => _EditDriverScreenState();
}

class _EditDriverScreenState extends State<EditDriverScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _license = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _license.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('save'))),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection(AppConstants.driversCollection).doc(widget.driverId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final d = snapshot.data!.data()!;
          _name.text = d['name'] ?? '';
          _phone.text = d['phone'] ?? '';
          _license.text = d['license_number'] ?? '';
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(controller: _name, label: l10n.t('name')),
                      const SizedBox(height: 12),
                      CustomTextField(controller: _phone, label: l10n.t('phone')),
                      const SizedBox(height: 12),
                      CustomTextField(controller: _license, label: 'License #'),
                      const SizedBox(height: 20),
                      CustomButton(
                        label: l10n.t('save'),
                        onPressed: () async {
                          await FirebaseFirestore.instance.collection(AppConstants.driversCollection).doc(widget.driverId).update({
                            'name': _name.text.trim(),
                            'phone': _phone.text.trim(),
                            'license_number': _license.text.trim(),
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
