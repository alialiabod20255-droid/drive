import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../widgets/common/custom_button.dart';
import '../../../../widgets/common/custom_textfield.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';

class AddDriverScreen extends StatefulWidget {
  const AddDriverScreen({super.key});

  @override
  State<AddDriverScreen> createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
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
      appBar: AppBar(title: Text(l10n.t('add'))),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(controller: _name, label: l10n.t('name'), validator: (v) => v != null && v.isNotEmpty ? null : l10n.t('name')),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _phone, label: l10n.t('phone'), keyboardType: TextInputType.phone, validator: (v) => v != null && v.isNotEmpty ? null : l10n.t('phone')),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _license, label: 'License #', validator: (v) => v != null && v.isNotEmpty ? null : 'License #'),
                  const SizedBox(height: 20),
                  CustomButton(
                    label: l10n.t('save'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await FirebaseFirestore.instance.collection(AppConstants.driversCollection).add({
                          'name': _name.text.trim(),
                          'phone': _phone.text.trim(),
                          'license_number': _license.text.trim(),
                          'points': AppConstants.initialDriverPoints,
                          'license_suspended': false,
                          'created_at': DateTime.now().toIso8601String(),
                        });
                        if (mounted) Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
