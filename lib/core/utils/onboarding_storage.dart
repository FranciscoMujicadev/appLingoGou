// lib/core/utils/onboarding_storage.dart

import 'package:shared_preferences/shared_preferences.dart';

class OnboardingStorage {
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';
  static const String _hasSeenGuideTourKey = 'has_seen_guide_tour';
  static const String _goalKey = 'onboarding_goal';
  static const String _timeKey = 'onboarding_time';
  static const String _levelKey = 'onboarding_level';
  static const String _sourceKey = 'onboarding_source';
  static const String _levelStartKey = 'onboarding_level_start';
  static const String _todaySessionsPrefix = 'today_sessions';
  static const String _goalCelebratedPrefix = 'goal_celebrated';

  static String _todayStr() {
    // Zero-padded para garantizar orden lexicográfico correcto y
    // evitar colisiones entre claves antiguas (ej: "2026-1-1" vs "2026-01-01")
    final now = DateTime.now();
    final mm = now.month.toString().padLeft(2, '0');
    final dd = now.day.toString().padLeft(2, '0');
    return '${now.year}-$mm-$dd';
  }

  /// Elimina claves de sesión y celebración más antiguas que [keepDays] días.
  /// Llama esto en el arranque (ej: en main) para evitar que SharedPreferences
  /// crezca indefinidamente con 365+ claves de días pasados.
  static Future<void> cleanupStaleSessionKeys({int keepDays = 7}) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final keys = prefs.getKeys().where((k) =>
        k.startsWith(_todaySessionsPrefix) ||
        k.startsWith(_goalCelebratedPrefix));

    for (final key in keys) {
      // Extraer la fecha del sufijo "prefix_YYYY-MM-DD"
      final suffix = key.contains('_') ? key.split('_').last : null;
      if (suffix == null) continue;
      final parts = suffix.split('-');
      if (parts.length != 3) continue;
      final year = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final day = int.tryParse(parts[2]);
      if (year == null || month == null || day == null) continue;
      final keyDate = DateTime(year, month, day);
      if (today.difference(keyDate).inDays > keepDays) {
        await prefs.remove(key);
      }
    }
  }

  static int _goalSessionsFromTime(String? time) {
    switch (time) {
      case '3 min/día': return 1;
      case '10 min/día': return 2;
      case '15 min/día': return 3;
      case '30 min/día': return 5;
      default: return 0;
    }
  }

  static Future<int> getDailyGoalSessions() async {
    final time = await getTime();
    return _goalSessionsFromTime(time);
  }

  static Future<int> incrementTodaySessions() async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_todaySessionsPrefix}_${_todayStr()}';
    final current = prefs.getInt(key) ?? 0;
    final newCount = current + 1;
    await prefs.setInt(key, newCount);
    return newCount;
  }

  static Future<bool> hasCelebratedGoalToday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('${_goalCelebratedPrefix}_${_todayStr()}') ?? false;
  }

  static Future<void> markGoalCelebratedToday() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${_goalCelebratedPrefix}_${_todayStr()}', true);
  }

  // === ONBOARDING ===
  // Verificar si el usuario ya vio el onboarding
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenOnboardingKey) ?? false;
  }

  // Marcar el onboarding como visto y guardar las selecciones
  static Future<void> setOnboardingCompleted({
    String? goal,
    String? time,
    String? level,
    String? levelStart,
    String? source,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenOnboardingKey, true);
    if (goal != null) await prefs.setString(_goalKey, goal);
    if (time != null) await prefs.setString(_timeKey, time);
    if (level != null) await prefs.setString(_levelKey, level);
    if (levelStart != null) await prefs.setString(_levelStartKey, levelStart);
    if (source != null) await prefs.setString(_sourceKey, source);
  }

  static const Map<String, String> _levelStartingCategory = {
    'Intermedio': 'Nivel 31',
    'Avanzado': 'Nivel 61',
  };

  /// Returns the category name to start from based on level + levelStart preference.
  /// Returns null if the user should start from the default (Nivel 1).
  static Future<String?> getStartingCategoryName() async {
    final prefs = await SharedPreferences.getInstance();
    final level = prefs.getString(_levelKey);
    final levelStart = prefs.getString(_levelStartKey);
    if (levelStart != 'mi_nivel') return null;
    return _levelStartingCategory[level];
  }

  static Future<String?> getGoal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_goalKey);
  }

  static Future<String?> getTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_timeKey);
  }

  static Future<String?> getLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_levelKey);
  }

  // === GUIDE TOUR ===
  // Verificar si el usuario ya vio la guía de tour
  static Future<bool> hasSeenGuideTour() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenGuideTourKey) ?? false;
  }

  // Marcar la guía de tour como completada
  static Future<void> setGuideTourCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenGuideTourKey, true);
  }

  // Resetear la guía de tour
  static Future<void> resetGuideTour() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_hasSeenGuideTourKey);
  }

  // === GENERAL ===
  // Resetear todo (útil para testing)
  static Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_hasSeenOnboardingKey);
  }
}
