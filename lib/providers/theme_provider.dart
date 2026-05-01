// lib/providers/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _darkModeKey = 'isDarkMode';

  // ─── Dark/light mode ──────────────────────────────────────────────────────
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  // ─── Tenant brand colors ──────────────────────────────────────────────────
  static const Color _defaultPrimary = Color(0xFF6C63FF);
  Color _primaryColor   = _defaultPrimary;
  Color _secondaryColor = const Color(0xFF98989D);

  Color get primaryColor   => _primaryColor;
  Color get secondaryColor => _secondaryColor;

  ThemeProvider() {
    _loadDarkMode();
  }

  // ─── Load ─────────────────────────────────────────────────────────────────

  Future<void> _loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_darkModeKey) ?? false;
    notifyListeners();
  }

  // ─── Public API ───────────────────────────────────────────────────────────

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, _isDarkMode);
    notifyListeners();
  }

  /// Called after a successful tenant login or re-verification.
  void applyTenantColors(String? primaryHex, String? secondaryHex) {
    _applyColors(primaryHex, secondaryHex);
  }

  /// Resets to default brand colors (used on tenant logout).
  void resetTenantColors() {
    _primaryColor   = _defaultPrimary;
    _secondaryColor = const Color(0xFF98989D);
    notifyListeners();
  }

  // ─── Internal helpers ─────────────────────────────────────────────────────

  void _applyColors(String? primaryHex, String? secondaryHex) {
    bool changed = false;
    if (primaryHex != null) {
      final c = _hexToColor(primaryHex);
      if (c != null) {
        _primaryColor = c;
        changed = true;
      }
    }
    if (secondaryHex != null) {
      final c = _hexToColor(secondaryHex);
      if (c != null) {
        _secondaryColor = c;
        changed = true;
      }
    }
    if (changed) notifyListeners();
  }

  static Color? _hexToColor(String hex) {
    try {
      final clean = hex.replaceAll('#', '').trim();
      if (clean.length == 6) {
        return Color(int.parse('FF$clean', radix: 16));
      } else if (clean.length == 8) {
        return Color(int.parse(clean, radix: 16));
      }
    } catch (_) {}
    return null;
  }
}
