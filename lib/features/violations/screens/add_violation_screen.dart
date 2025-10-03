import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traffic_violations_app/core/constants/app_constants.dart';
import 'package:traffic_violations_app/core/localization/app_localizations.dart';
import 'package:traffic_violations_app/widgets/common/custom_button.dart';
import 'package:traffic_violations_app/widgets/common/custom_textfield.dart';

class AddViolationScreen extends StatefulWidget {
  const AddViolationScreen({super.key});

  @override
  State<AddViolationScreen> createState() => _AddViolationScreenState();
}

class _AddViolationScreenState extends State<AddViolationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _driverId = TextEditingController();
  final _type = TextEditingController();
  final _points = TextEditingController(text: '1');
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _driverId.dispose();
    _type.dispose();
    _points.dispose();
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
                  CustomTextField(controller: _driverId, label: 'Driver ID', validator: (v) => v != null && v.isNotEmpty ? null : 'Driver ID'),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _type, label: 'Type', validator: (v) => v != null && v.isNotEmpty ? null : 'Type'),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _points, label: 'Points Deducted', keyboardType: TextInputType.number, validator: (v) => int.tryParse(v ?? '') != null ? null : 'Points'),
                  const SizedBox(height: 12),
                  CustomButton(
                    label: l10n.t('save'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final pts = int.parse(_points.text);
                        await FirebaseFirestore.instance.collection(AppConstants.violationsCollection).add({
                          'driver_id': _driverId.text.trim(),
                          'type': _type.text.trim(),
                          'points_deducted': pts,
                          'date': DateTime.now().toIso8601String(),
                          'status': 'pending',
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
