// lib/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ─── Brand purple ────────────────────────────────────────────────────────
  static const Color primaryPurple = Color(0xFF6C63FF);

  // ─── Dark palette (current app look) ───────────────────────────────────
  static const Color _darkScaffold = Color(0xFF000000);
  static const Color _darkSurface = Color(0xFF1C1C1E);
  static const Color _darkCard = Color(0xFF1A1A1A);
  static const Color _darkNavBar = Color(0xFF2C2C2E);
  static const Color _darkNavBarBorder = Color(0xFF3A3A3C);
  static const Color _darkOnSurface = Colors.white;
  static const Color _darkSecondary = Color(0xFF98989D);
  static const Color _darkDivider = Color(0xFF3A3A3C);

  // ─── Light palette ──────────────────────────────────────────────────────
  static const Color _lightScaffold = Color(0xFFF2F2F7);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightCard = Color(0xFFFFFFFF);
  static const Color _lightNavBar = Color(0xFFFFFFFF);
  static const Color _lightNavBarBorder = Color(0xFFE5E5EA);
  static const Color _lightOnSurface = Color(0xFF1C1C1E);
  static const Color _lightSecondary = Color(0xFF6C6C70);
  static const Color _lightDivider = Color(0xFFE5E5EA);

  static String get _fontFamily => GoogleFonts.plusJakartaSans().fontFamily!;

  static TextTheme _buildTextTheme(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;
    return GoogleFonts.plusJakartaSansTextTheme(base);
  }

  // ─── Dark theme (with optional tenant primary color) ────────────────────
  static ThemeData darkThemeWith({Color primary = primaryPurple}) => ThemeData(
        brightness: Brightness.dark,
        fontFamily: _fontFamily,
        textTheme: _buildTextTheme(Brightness.dark),
        scaffoldBackgroundColor: _darkScaffold,
        cardColor: _darkCard,
        dividerColor: _darkDivider,
        colorScheme: ColorScheme.dark(
          primary: primary,
          surface: _darkSurface,
          onSurface: _darkOnSurface,
          secondary: _darkSecondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: _darkNavBar,
          foregroundColor: _darkOnSurface,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: _darkNavBar,
          selectedItemColor: primary,
          unselectedItemColor: _darkSecondary,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: Colors.white,
          unselectedLabelColor: _darkSecondary,
          indicator: BoxDecoration(
            color: primary,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
        ),
      );

  // ─── Light theme (with optional tenant primary color) ───────────────────
  static ThemeData lightThemeWith({Color primary = primaryPurple}) => ThemeData(
        brightness: Brightness.light,
        fontFamily: _fontFamily,
        textTheme: _buildTextTheme(Brightness.light),
        scaffoldBackgroundColor: _lightScaffold,
        cardColor: _lightCard,
        dividerColor: _lightDivider,
        colorScheme: ColorScheme.light(
          primary: primary,
          surface: _lightSurface,
          onSurface: _lightOnSurface,
          secondary: _lightSecondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: _lightNavBar,
          foregroundColor: _lightOnSurface,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: _lightNavBar,
          selectedItemColor: primary,
          unselectedItemColor: _lightSecondary,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: _lightOnSurface,
          unselectedLabelColor: _lightSecondary,
          indicator: BoxDecoration(
            color: primary,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
        ),
      );

  // ─── Legacy getters (keep backward compatibility) ────────────────────────
  static ThemeData get darkTheme  => darkThemeWith();
  static ThemeData get lightTheme => lightThemeWith();

  // ─── Helpers accessible by screens ──────────────────────────────────────

  static Color cardColor(BuildContext context) =>
      Theme.of(context).cardColor;

  static Color navBarColor(BuildContext context) =>
      Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
      Theme.of(context).colorScheme.surface;

  static Color navBarBorderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? _darkNavBarBorder
          : _lightNavBarBorder;

  static Color secondaryTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? _darkSecondary
          : _lightSecondary;
}
