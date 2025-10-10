// Archivo: lib/core/services/progress_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/day_progress_model.dart';

class ProgressService {
  static const String _progressKey = 'day_progress';
  static const String _firstLaunchKey = 'first_launch';

  Future<Map<String, DayProgressModel>> getProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final progressJson = prefs.getString(_progressKey);

    if (progressJson == null) {
      return _initializeProgress();
    }

    final Map<String, dynamic> progressMap = json.decode(progressJson);
    return progressMap.map(
      (key, value) => MapEntry(
        key,
        DayProgressModel.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  Map<String, DayProgressModel> _initializeProgress() {
    return {
      'Día 1': const DayProgressModel(dayId: 'Día 1', isUnlocked: true),
      'Día 2': const DayProgressModel(dayId: 'Día 2'),
      'Día 3': const DayProgressModel(dayId: 'Día 3'),
      'Día 4': const DayProgressModel(dayId: 'Día 4'),
      'Día 5': const DayProgressModel(dayId: 'Día 5'),
    };
  }

  Future<void> saveProgress(Map<String, DayProgressModel> progress) async {
    final prefs = await SharedPreferences.getInstance();
    final progressMap = progress.map(
      (key, value) => MapEntry(key, value.toJson()),
    );
    await prefs.setString(_progressKey, json.encode(progressMap));
  }

  Future<void> markPhraseAsUsed(String dayId, int phraseIndex) async {
    final progress = await getProgress();
    final dayProgress = progress[dayId];

    if (dayProgress == null || !dayProgress.isUnlocked) return;

    final updatedPhrasesUsed = List<bool>.from(dayProgress.phrasesUsed);
    updatedPhrasesUsed[phraseIndex] = true;

    final updatedDay = dayProgress.copyWith(phrasesUsed: updatedPhrasesUsed);
    progress[dayId] = updatedDay;

    if (updatedDay.allPhrasesUsed) {
      await _completeDay(progress, dayId);
    }

    await saveProgress(progress);
  }

  Future<void> _completeDay(
    Map<String, DayProgressModel> progress,
    String dayId,
  ) async {
    final dayProgress = progress[dayId];
    if (dayProgress == null) return;

    progress[dayId] = dayProgress.copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
    );

    final dayNumber = int.tryParse(dayId.replaceAll('Día ', ''));
    if (dayNumber != null && dayNumber < 5) {
      final nextDayId = 'Día ${dayNumber + 1}';
      final nextDay = progress[nextDayId];
      if (nextDay != null) {
        progress[nextDayId] = nextDay.copyWith(isUnlocked: true);
      }
    }
  }

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstLaunchKey) ?? true;
  }

  Future<void> setFirstLaunchComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, false);
  }

  Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_progressKey);
    await prefs.remove(_firstLaunchKey);
  }

  Future<String> getFirstUnlockedDay() async {
    final progress = await getProgress();

    for (var i = 1; i <= 5; i++) {
      final dayId = 'Día $i';
      final dayProgress = progress[dayId];
      if (dayProgress != null &&
          dayProgress.isUnlocked &&
          !dayProgress.isCompleted) {
        return dayId;
      }
    }

    return 'Día 1';
  }

  Future<void> completeDayAndUnlockNext(String currentDay) async {
    final progress = await getProgress();
    final dayProgress = progress[currentDay];

    if (dayProgress == null) return;

    // Marcar día como completado
    progress[currentDay] = dayProgress.copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
    );

    // Desbloquear siguiente día
    final dayNumber = int.tryParse(currentDay.replaceAll('Día ', ''));
    if (dayNumber != null && dayNumber < 5) {
      final nextDayId = 'Día ${dayNumber + 1}';
      final nextDay = progress[nextDayId];
      if (nextDay != null) {
        progress[nextDayId] = nextDay.copyWith(isUnlocked: true);
      }
    }

    await saveProgress(progress);
  }

  Future<void> confirmDayChallenge(String dayId) async {
    final progress = await getProgress();
    final dayProgress = progress[dayId];

    if (dayProgress == null) return;

    // Marcar como confirmado
    progress[dayId] = dayProgress.copyWith(challengeConfirmed: true);

    await saveProgress(progress);
  }
}
