import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart';
import '../models/driver_model.dart';
import '../models/violation_model.dart';

class ViolationRepository {
  final FirebaseFirestore _db;
  ViolationRepository(this._db);

  CollectionReference<Map<String, dynamic>> get _col => _db.collection(AppConstants.violationsCollection);
  CollectionReference<Map<String, dynamic>> get _drivers => _db.collection(AppConstants.driversCollection);

  Stream<List<ViolationModel>> watchAll() {
    return _col.orderBy('date', descending: true).snapshots().map((s) => s.docs.map((d) => ViolationModel.fromMap(d.id, d.data())).toList());
  }

  Future<String> add(ViolationModel violation) async {
    return _db.runTransaction((tx) async {
      final driverRef = _drivers.doc(violation.driverId);
      final driverSnap = await tx.get(driverRef);
      if (!driverSnap.exists) {
        throw Exception('Driver not found');
      }
      final driver = DriverModel.fromMap(driverSnap.id, driverSnap.data()!);
      final newPoints = (driver.points - violation.pointsDeducted).clamp(0, 9999);
      final suspended = newPoints <= 0;
      tx.update(driverRef, {
        'points': newPoints,
        'license_suspended': suspended,
      });
      final ref = _col.doc();
      tx.set(ref, violation.copyWith(id: ref.id).toMap());
      return ref.id;
    });
  }

  Future<void> update(ViolationModel violation) async {
    await _col.doc(violation.id).update(violation.toMap());
  }

  Future<void> delete(String id) async {
    await _col.doc(id).delete();
  }
}
