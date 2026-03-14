import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/services/firestore_service.dart';
import '../../core/utils/onboarding_storage.dart';
import '../../domain/usecases/stats_usecases.dart';

class StatsProvider extends ChangeNotifier {
  final GetStatsUseCase getStatsUseCase;
  final CheckAchievementsUseCase checkAchievementsUseCase;

  StatsProvider({
    required this.getStatsUseCase,
    required this.checkAchievementsUseCase,
  });

  Timer? _syncTimer;
  bool _isCollector = false;
  bool _hasFirstStep = false;
  bool _pendingGoalCelebration = false;
  String? _pendingGoalTime;

  int _phrasesViewed = 0;
  int _shareAttempts = 0;
  final Set<String> _exploredCategories = {};

  // Getters para logros
  bool get pendingGoalCelebration => _pendingGoalCelebration;
  String? get pendingGoalTime => _pendingGoalTime;
  bool get isSharer => _shareAttempts >= 3;
  bool get isMaster => _phrasesViewed >= 50;
  bool get isCollector => _isCollector;
  bool get isStudious => _phrasesViewed >= 20;
  bool get isExplorer => _exploredCategories.length >= 4;
  bool get hasFirstStep => _hasFirstStep;

  // Getters para estadísticas
  int get phrasesViewed => _phrasesViewed;
  int get shareAttempts => _shareAttempts;
  int get categoriesExplored => _exploredCategories.length;
  Set<String> get exploredCategories => _exploredCategories;

  int getUnlockedAchievementsCount() {
    int count = 0;
    if (hasFirstStep) count++;
    if (isCollector) count++;
    if (isStudious) count++;
    if (isExplorer) count++;
    if (isSharer) count++;
    if (isMaster) count++;
    return count;
  }

  Future<void> loadStats() async {
    try {
      final stats = await getStatsUseCase();

      // Casteo defensivo: el tipo puede venir como num desde JSON o SharedPrefs
      final rawPhrases = stats['phrasesViewed'];
      final rawShares = stats['shareAttempts'];
      _phrasesViewed = (rawPhrases is num)
          ? rawPhrases.toInt()
          : int.tryParse(rawPhrases?.toString() ?? '') ?? 0;
      _shareAttempts = (rawShares is num)
          ? rawShares.toInt()
          : int.tryParse(rawShares?.toString() ?? '') ?? 0;

      _exploredCategories.clear();
      final rawCats = stats['exploredCategories'];
      if (rawCats is Set<String>) {
        _exploredCategories.addAll(rawCats);
      } else if (rawCats is Iterable) {
        for (final item in rawCats) {
          if (item is String && item.isNotEmpty) {
            _exploredCategories.add(item);
          }
        }
      }

      if (_phrasesViewed > 0) _hasFirstStep = true;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) debugPrint('StatsProvider.loadStats error: $e');
      // No relanzamos — el estado queda en 0 y el usuario puede continuar
    }
  }

  void incrementPhrasesViewed(String phraseId) {
    _phrasesViewed++;
    final crossed = !_hasFirstStep ||
        _phrasesViewed == 20 ||
        _phrasesViewed == 50;
    if (!_hasFirstStep) _hasFirstStep = true;
    if (crossed) notifyListeners(); // solo en umbrales de logro
    _syncToFirestore();
  }

  void incrementShare() {
    _shareAttempts++;
    notifyListeners();
    _syncToFirestore();
  }

  void addExploredCategory(String category) {
    _exploredCategories.add(category);
    _checkDailyGoal();
    notifyListeners();
    _syncToFirestore();
  }

  void _syncToFirestore() {
    _syncTimer?.cancel();
    _syncTimer = Timer(const Duration(seconds: 3), () {
      FirestoreService.saveStats(
        phrasesViewed: _phrasesViewed,
        shareAttempts: _shareAttempts,
        exploredCategories: Set.unmodifiable(_exploredCategories),
      );
    });
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    super.dispose();
  }

  /// Aplica datos descargados de Firestore tomando el máximo/unión local+cloud.
  void restoreFromCloud({
    required int phrasesViewed,
    required int shareAttempts,
    required Set<String> exploredCategories,
  }) {
    if (phrasesViewed > _phrasesViewed) _phrasesViewed = phrasesViewed;
    if (shareAttempts > _shareAttempts) _shareAttempts = shareAttempts;
    _exploredCategories.addAll(exploredCategories);
    if (_phrasesViewed > 0) _hasFirstStep = true;
    notifyListeners();
  }

  Future<void> _checkDailyGoal() async {
    final newCount = await OnboardingStorage.incrementTodaySessions();
    final goal = await OnboardingStorage.getDailyGoalSessions();
    final alreadyCelebrated = await OnboardingStorage.hasCelebratedGoalToday();
    if (goal > 0 && newCount >= goal && !alreadyCelebrated) {
      _pendingGoalTime = await OnboardingStorage.getTime();
      _pendingGoalCelebration = true;
      notifyListeners();
    }
  }

  void clearPendingGoalCelebration() {
    _pendingGoalCelebration = false;
    _pendingGoalTime = null;
  }

  Future<void> updateAchievements(int favoritesCount) async {
    _isCollector = favoritesCount >= 5;
    notifyListeners();
  }

  void resetStats() {
    _phrasesViewed = 0;
    _shareAttempts = 0;
    _exploredCategories.clear();
    _isCollector = false;
    notifyListeners();
  }
}
