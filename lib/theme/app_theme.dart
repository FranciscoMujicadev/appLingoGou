// lib/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  // ─── Brand purple ────────────────────────────────────────────────────────
  static const Color primaryPurple = Color(0xFF6C63FF);

  // ─── Dark palette (current app look) ───────────────────────────────────
  static const Color _darkScaffold = Color(0xFF000000);
  static const Color _darkSurface = Color(0xFF1C1C1E);
  static const Color _darkCard = Color(0xFF1A1A1A);
  static const Color _darkNavBar = Color(0xFF2C2C2E);
  static const Color _darkNavBarBorder = Color(0xFF3A3A3C);
  static const Color _darkPrimary = primaryPurple;
  static const Color _darkOnSurface = Colors.white;
  static const Color _darkSecondary = Color(0xFF98989D);
  static const Color _darkDivider = Color(0xFF3A3A3C);

  // ─── Light palette ──────────────────────────────────────────────────────
  static const Color _lightScaffold = Color(0xFFF2F2F7);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightCard = Color(0xFFFFFFFF);
  static const Color _lightNavBar = Color(0xFFFFFFFF);
  static const Color _lightNavBarBorder = Color(0xFFE5E5EA);
  static const Color _lightPrimary = primaryPurple;
  static const Color _lightOnSurface = Color(0xFF1C1C1E);
  static const Color _lightSecondary = Color(0xFF6C6C70);
  static const Color _lightDivider = Color(0xFFE5E5EA);

  // ─── Shared text theme (Roboto weights, no color – auto from brightness) ─
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
    displaySmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
    headlineLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
  );

  // ─── Dark theme ─────────────────────────────────────────────────────────
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        textTheme: _textTheme,
        scaffoldBackgroundColor: _darkScaffold,
        cardColor: _darkCard,
        dividerColor: _darkDivider,
        colorScheme: const ColorScheme.dark(
          primary: _darkPrimary,
          surface: _darkSurface,
          onSurface: _darkOnSurface,
          secondary: _darkSecondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: _darkNavBar,
          foregroundColor: _darkOnSurface,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: _darkNavBar,
          selectedItemColor: _darkPrimary,
          unselectedItemColor: _darkSecondary,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: Colors.white,
          unselectedLabelColor: _darkSecondary,
          indicator: BoxDecoration(
            color: primaryPurple,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      );

  // ─── Light theme ────────────────────────────────────────────────────────
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Roboto',
        textTheme: _textTheme,
        scaffoldBackgroundColor: _lightScaffold,
        cardColor: _lightCard,
        dividerColor: _lightDivider,
        colorScheme: const ColorScheme.light(
          primary: _lightPrimary,
          surface: _lightSurface,
          onSurface: _lightOnSurface,
          secondary: _lightSecondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: _lightNavBar,
          foregroundColor: _lightOnSurface,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: _lightNavBar,
          selectedItemColor: _lightPrimary,
          unselectedItemColor: _lightSecondary,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: _lightOnSurface,
          unselectedLabelColor: _lightSecondary,
          indicator: BoxDecoration(
            color: _lightPrimary,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      );

  // ─── Helpers accessible by screens ──────────────────────────────────────

  /// Card/container background based on current theme.
  static Color cardColor(BuildContext context) =>
      Theme.of(context).cardColor;

  /// Nav bar background color.
  static Color navBarColor(BuildContext context) =>
      Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
      Theme.of(context).colorScheme.surface;

  /// Nav bar top-border color.
  static Color navBarBorderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? _darkNavBarBorder
          : _lightNavBarBorder;

  /// Secondary text / icon color.
  static Color secondaryTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? _darkSecondary
          : _lightSecondary;
}
