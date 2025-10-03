import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/app_constants.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  AuthRepository(this._auth, this._db);

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<AppUser?> getCurrentUserProfile() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    final doc = await _db.collection(AppConstants.usersCollection).doc(uid).get();
    if (!doc.exists) return null;
    return AppUser.fromMap(doc.id, doc.data()!);
  }

  Future<UserCredential> loginWithEmail(String email, String password) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<UserCredential> registerWithEmail({required String name, required String email, required String phone, required String password, required String role}) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _db.collection(AppConstants.usersCollection).doc(cred.user!.uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'created_at': DateTime.now().toIso8601String(),
    });
    return cred;
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> startPhoneSignIn({required String phoneNumber, required Function(String verificationId) codeSent, required Function(String message) onError}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (cred) async {
        await _auth.signInWithCredential(cred);
      },
      verificationFailed: (e) => onError(e.message ?? 'Phone auth failed'),
      codeSent: (id, _) => codeSent(id),
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  Future<void> confirmSmsCode(String verificationId, String smsCode) async {
    final cred = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await _auth.signInWithCredential(cred);
  }
}
