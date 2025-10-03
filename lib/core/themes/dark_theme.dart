import 'package:flutter/material.dart';

ThemeData buildDarkTheme(Color? seed) {
  final colorScheme = ColorScheme.fromSeed(seedColor: seed ?? const Color(0xFF0D47A1), brightness: Brightness.dark);
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colorScheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      centerTitle: true,
      elevation: 0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(12),
    ),
  );
}
