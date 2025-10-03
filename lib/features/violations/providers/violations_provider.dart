import 'package:flutter/material.dart';
import '../../../data/models/violation_model.dart';
import '../../../data/repositories/violation_repository.dart';

class ViolationsProvider extends ChangeNotifier {
  final ViolationRepository repo;
  ViolationsProvider(this.repo) {
    _sub = repo.watchAll().listen((value) {
      _violations = value;
      notifyListeners();
    });
  }

  List<ViolationModel> _violations = [];
  List<ViolationModel> get violations => _violations;
  dynamic _sub;

  Future<String> add(ViolationModel v) => repo.add(v);
  Future<void> update(ViolationModel v) => repo.update(v);
  Future<void> delete(String id) => repo.delete(id);

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
