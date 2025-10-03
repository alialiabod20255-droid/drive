import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Locale _locale = const Locale('ar');
  Locale get locale => _locale;

  Color _customSeed = const Color(0xFF1565C0);
  Color get customSeed => _customSeed;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString(AppConstants.prefThemeMode);
    final loc = prefs.getString(AppConstants.prefLocale);
    final seedVal = prefs.getInt(AppConstants.prefCustomSeed);
    if (mode != null) {
      _themeMode = _fromString(mode);
    }
    if (loc != null) {
      _locale = Locale(loc);
    }
    if (seedVal != null) {
      _customSeed = Color(seedVal);
    }
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefThemeMode, _toString(mode));
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefLocale, locale.languageCode);
    notifyListeners();
  }

  Future<void> setCustomSeed(Color color) async {
    _customSeed = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.prefCustomSeed, color.value);
    notifyListeners();
  }

  String _toString(ThemeMode mode) => switch (mode) { ThemeMode.light => 'light', ThemeMode.dark => 'dark', _ => 'system' };
  ThemeMode _fromString(String v) => switch (v) { 'light' => ThemeMode.light, 'dark' => ThemeMode.dark, 'custom' => ThemeMode.system, _ => ThemeMode.system };
}
