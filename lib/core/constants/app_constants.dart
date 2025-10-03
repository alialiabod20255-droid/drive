class AppConstants {
  static const String appTitleEn = 'Traffic Violations Manager';
  static const String appTitleAr = 'نظام إدارة مخالفات السير';

  // Firestore collections
  static const String usersCollection = 'users';
  static const String driversCollection = 'drivers';
  static const String violationsCollection = 'violations';
  static const String notificationsCollection = 'notifications';

  // Business rules
  static const int initialDriverPoints = 12;

  // SharedPreferences keys
  static const String prefThemeMode = 'pref_theme_mode';
  static const String prefLocale = 'pref_locale';
  static const String prefCustomSeed = 'pref_custom_seed_color';
}
