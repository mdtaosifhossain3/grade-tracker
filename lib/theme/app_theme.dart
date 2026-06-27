import 'package:flutter/material.dart';

/// Fully custom ThemeData for light and dark modes.
/// No hardcoded colors in widgets — all sourced from Theme.of(context).
class AppTheme {
  AppTheme._();

  // ── Shared color constants ─────────────────────────────────────────────────
  static const _primaryLight = Color(0xFF5C35C9); // deep violet
  static const _onPrimaryLight = Color(0xFFFFFFFF);
  static const _secondaryLight = Color(0xFF7C5FE0);
  static const _surfaceLight = Color(0xFFF4F2FF);
  static const _backgroundLight = Color(0xFFFFFFFF);
  static const _onSurfaceLight = Color(0xFF1A1035);
  static const _errorLight = Color(0xFFB00020);

  static const _primaryDark = Color(0xFF9B7BFF); // soft violet
  static const _onPrimaryDark = Color(0xFF1A0060);
  static const _secondaryDark = Color(0xFF7C5FE0);
  static const _surfaceDark = Color(0xFF1E1B2E);
  static const _backgroundDark = Color(0xFF13111F);
  static const _onSurfaceDark = Color(0xFFE8E0FF);
  static const _errorDark = Color(0xFFCF6679);

  // ── Light Theme ────────────────────────────────────────────────────────────
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: _primaryLight,
          onPrimary: _onPrimaryLight,
          secondary: _secondaryLight,
          onSecondary: _onPrimaryLight,
          error: _errorLight,
          onError: _onPrimaryLight,
          surface: _surfaceLight,
          onSurface: _onSurfaceLight,
        ),
        scaffoldBackgroundColor: _backgroundLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: _primaryLight,
          foregroundColor: _onPrimaryLight,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: _onPrimaryLight,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        cardTheme: CardThemeData(
          color: _surfaceLight,
          elevation: 4,
          shadowColor: Color(0x335C35C9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _surfaceLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: _primaryLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFFB0A0E8), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: _primaryLight, width: 2),
          ),
          labelStyle: TextStyle(color: _secondaryLight),
          floatingLabelStyle: TextStyle(color: _primaryLight),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryLight,
            foregroundColor: _onPrimaryLight,
            minimumSize: Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
            elevation: 4,
            shadowColor: Color(0x665C35C9),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: _backgroundLight,
          selectedItemColor: _primaryLight,
          unselectedItemColor: Color(0xFF9E9DB5),
          showUnselectedLabels: true,
          elevation: 12,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 11),
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: _onSurfaceLight,
            fontWeight: FontWeight.w800,
            fontSize: 28,
          ),
          headlineMedium: TextStyle(
            color: _onSurfaceLight,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          titleLarge: TextStyle(
            color: _onSurfaceLight,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          bodyLarge: TextStyle(color: _onSurfaceLight, fontSize: 16),
          bodyMedium: TextStyle(color: _onSurfaceLight, fontSize: 14),
          bodySmall: TextStyle(color: Color(0xFF6B628E), fontSize: 12),
        ),
        dividerColor: Color(0xFFD6CFFF),
        iconTheme: const IconThemeData(color: _primaryLight),
      );

  // ── Dark Theme ─────────────────────────────────────────────────────────────
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: _primaryDark,
          onPrimary: _onPrimaryDark,
          secondary: _secondaryDark,
          onSecondary: _onPrimaryDark,
          error: _errorDark,
          onError: _backgroundDark,
          surface: _surfaceDark,
          onSurface: _onSurfaceDark,
        ),
        scaffoldBackgroundColor: _backgroundDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: _surfaceDark,
          foregroundColor: _onSurfaceDark,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: _onSurfaceDark,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        cardTheme: CardThemeData(
          color: _surfaceDark,
          elevation: 8,
          shadowColor: Color(0x559B7BFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF2A2545),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: _primaryDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFF5A4A9E), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: _primaryDark, width: 2),
          ),
          labelStyle: TextStyle(color: Color(0xFFB0A0FF)),
          floatingLabelStyle: TextStyle(color: _primaryDark),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryDark,
            foregroundColor: _onPrimaryDark,
            minimumSize: Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
            elevation: 4,
            shadowColor: Color(0x669B7BFF),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: _surfaceDark,
          selectedItemColor: _primaryDark,
          unselectedItemColor: Color(0xFF706C9A),
          showUnselectedLabels: true,
          elevation: 12,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 11),
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: _onSurfaceDark,
            fontWeight: FontWeight.w800,
            fontSize: 28,
          ),
          headlineMedium: TextStyle(
            color: _onSurfaceDark,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          titleLarge: TextStyle(
            color: _onSurfaceDark,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          bodyLarge: TextStyle(color: _onSurfaceDark, fontSize: 16),
          bodyMedium: TextStyle(color: _onSurfaceDark, fontSize: 14),
          bodySmall: TextStyle(color: Color(0xFF9B96CC), fontSize: 12),
        ),
        dividerColor: Color(0xFF3A3560),
        iconTheme: const IconThemeData(color: _primaryDark),
      );

  /// Returns a color appropriate for the given [grade], sourced relative to
  /// the provided [colorScheme] so no hardcoded colors leak into widgets.
  static Color gradeColor(String grade, ColorScheme colorScheme) {
    switch (grade) {
      case 'A':
        return colorScheme.brightness == Brightness.dark
            ? const Color(0xFF4CAF50)
            : const Color(0xFF2E7D32);
      case 'B':
        return colorScheme.brightness == Brightness.dark
            ? const Color(0xFF42A5F5)
            : const Color(0xFF1565C0);
      case 'C':
        return colorScheme.brightness == Brightness.dark
            ? const Color(0xFFFFCA28)
            : const Color(0xFFF57F17);
      default: // F
        return colorScheme.error;
    }
  }
}
