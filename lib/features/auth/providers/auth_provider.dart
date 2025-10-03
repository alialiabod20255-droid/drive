import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repo;
  AuthProvider(this.repo) {
    repo.authStateChanges().listen((_) async {
      await _loadProfile();
    });
  }

  AppUser? _profile;
  AppUser? get profile => _profile;
  bool get isAuthenticated => FirebaseAuth.instance.currentUser != null;

  bool _loading = false;
  bool get loading => _loading;
  String? _error;
  String? get error => _error;

  Future<void> _loadProfile() async {
    _profile = await repo.getCurrentUserProfile();
    notifyListeners();
  }

  Future<void> loginWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      await repo.loginWithEmail(email, password);
      await _loadProfile();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register({required String name, required String email, required String phone, required String password, required String role}) async {
    _setLoading(true);
    try {
      await repo.registerWithEmail(name: name, email: email, phone: phone, password: password, role: role);
      await _loadProfile();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await repo.resetPassword(email);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() => repo.logout();

  void _setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }
}
