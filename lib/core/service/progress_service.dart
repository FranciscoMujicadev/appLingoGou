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
    final progress = progressMap.map(
      (key, value) => MapEntry(
        key,
        DayProgressModel.fromJson(value as Map<String, dynamic>),
      ),
    );

    // Usuarios con progreso antiguo no tendrán los niveles Business English.
    _ensureBusinessLevels(progress);

    return progress;
  }

  Map<String, DayProgressModel> _initializeProgress() {
    final progress = <String, DayProgressModel>{};

    // Módulo Inglés Coloquial (1-100)
    for (int i = 1; i <= 100; i++) {
      progress['Nivel $i'] = DayProgressModel(
        dayId: 'Nivel $i',
        isUnlocked: i == 1, // Solo el nivel 1 desbloqueado
      );
    }

    // Módulo Business English (101-120) — nivel 101 desbloqueado de entrada
    for (int i = 101; i <= 120; i++) {
      progress['Nivel $i'] = DayProgressModel(
        dayId: 'Nivel $i',
        isUnlocked: i == 101,
      );
    }

    return progress;
  }

  /// Garantiza que todos los niveles Business English existen en el mapa.
  /// Útil cuando el usuario ya tenía progreso guardado antes de que
  /// se añadiese el módulo.
  void _ensureBusinessLevels(Map<String, DayProgressModel> progress) {
    for (int i = 101; i <= 120; i++) {
      if (!progress.containsKey('Nivel $i')) {
        progress['Nivel $i'] = DayProgressModel(
          dayId: 'Nivel $i',
          isUnlocked: i == 101,
        );
      }
    }
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

    final dayNumber = int.tryParse(dayId.replaceAll('Nivel ', ''));
    if (dayNumber != null) {
      final nextDayId = 'Nivel ${dayNumber + 1}';
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

    for (var i = 1; i <= 120; i++) {
      final dayId = 'Nivel $i';
      final dayProgress = progress[dayId];
      if (dayProgress != null &&
          dayProgress.isUnlocked &&
          !dayProgress.isCompleted) {
        return dayId;
      }
    }

    return 'Nivel 1';
  }

  Future<void> completeDayAndUnlockNext(String currentDay) async {
    final progress = await getProgress();
    final dayProgress = progress[currentDay];

    if (dayProgress == null) return;

    // Marcar nivel como completado
    progress[currentDay] = dayProgress.copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
    );

    final dayNumber = int.tryParse(currentDay.replaceAll('Nivel ', ''));
    if (dayNumber != null) {
      final nextDayId = 'Nivel ${dayNumber + 1}';
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
