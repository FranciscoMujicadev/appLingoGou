// lib/core/services/analytics_service.dart

import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Onboarding completado — evento principal para targeting
  static Future<void> logOnboardingCompleted({
    required String goal,
    required String studyTime,
    required String level,
    String? source,
  }) async {
    await _analytics.logEvent(
      name: 'onboarding_completed',
      parameters: {
        'goal': goal,
        'study_time': studyTime,
        'level': level,
        if (source != null) 'source': source,
      },
    );
    await _analytics.setUserProperty(name: 'goal', value: goal);
    await _analytics.setUserProperty(name: 'study_time', value: studyTime);
    await _analytics.setUserProperty(name: 'level', value: level);
    if (source != null) {
      await _analytics.setUserProperty(name: 'acquisition_source', value: source);
    }
  }

  // Nivel iniciado
  static Future<void> logLevelStarted(String levelName) async {
    await _analytics.logEvent(
      name: 'level_started',
      parameters: {'level_name': levelName},
    );
  }
}
