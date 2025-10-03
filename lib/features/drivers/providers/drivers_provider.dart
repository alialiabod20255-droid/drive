import 'package:flutter/material.dart';
import '../../../data/models/driver_model.dart';
import '../../../data/repositories/driver_repository.dart';

class DriversProvider extends ChangeNotifier {
  final DriverRepository repo;
  DriversProvider(this.repo) {
    _sub = repo.watchAll().listen((value) {
      _drivers = value;
      notifyListeners();
    });
  }

  late final Stream<List<DriverModel>> _stream = repo.watchAll();
  Stream<List<DriverModel>> get stream => _stream;
  List<DriverModel> _drivers = [];
  List<DriverModel> get drivers => _drivers;
  dynamic _sub;

  Future<String> add(DriverModel d) => repo.add(d);
  Future<void> update(DriverModel d) => repo.update(d);
  Future<void> delete(String id) => repo.delete(id);

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
