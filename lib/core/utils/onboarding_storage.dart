// lib/core/utils/onboarding_storage.dart

import 'package:shared_preferences/shared_preferences.dart';

class OnboardingStorage {
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';
  static const String _hasSeenGuideTourKey = 'has_seen_guide_tour';

  // === ONBOARDING ===
  // Verificar si el usuario ya vio el onboarding
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenOnboardingKey) ?? false;
  }

  // Marcar el onboarding como visto
  static Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenOnboardingKey, true);
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
