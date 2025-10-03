import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart';
import '../models/driver_model.dart';

class DriverRepository {
  final FirebaseFirestore _db;
  DriverRepository(this._db);

  CollectionReference<Map<String, dynamic>> get _col => _db.collection(AppConstants.driversCollection);

  Stream<List<DriverModel>> watchAll() {
    return _col.orderBy('created_at', descending: true).snapshots().map((s) => s.docs.map((d) => DriverModel.fromMap(d.id, d.data())).toList());
  }

  Future<DriverModel?> getById(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) return null;
    return DriverModel.fromMap(doc.id, doc.data()!);
  }

  Future<String> add(DriverModel driver) async {
    final ref = await _col.add(driver.toMap());
    return ref.id;
  }

  Future<void> update(DriverModel driver) async {
    await _col.doc(driver.id).update(driver.toMap());
  }

  Future<void> delete(String id) async {
    await _col.doc(id).delete();
  }
}
