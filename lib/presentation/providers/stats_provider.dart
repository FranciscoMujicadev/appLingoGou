import 'package:flutter/material.dart';
import '../../core/utils/onboarding_storage.dart';
import '../../domain/usecases/stats_usecases.dart';

class StatsProvider extends ChangeNotifier {
  final GetStatsUseCase getStatsUseCase;
  final CheckAchievementsUseCase checkAchievementsUseCase;

  StatsProvider({
    required this.getStatsUseCase,
    required this.checkAchievementsUseCase,
  });

  bool _isCollector = false;
  final bool _hasFirstStep = true;
  bool _pendingGoalCelebration = false;

  int _phrasesViewed = 0;
  int _shareAttempts = 0;
  final Set<String> _exploredCategories = {};

  // Getters para logros
  bool get pendingGoalCelebration => _pendingGoalCelebration;
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
      _phrasesViewed = stats['phrasesViewed'] as int;
      _shareAttempts = stats['shareAttempts'] as int;
      _exploredCategories.clear();
      _exploredCategories.addAll(stats['exploredCategories'] as Set<String>);
      notifyListeners();
    } catch (e) {
      // Manejar error si es necesario
    }
  }

  void incrementPhrasesViewed(String phraseId) {
    _phrasesViewed++;
    notifyListeners();
  }

  void incrementShare() {
    _shareAttempts++;
    notifyListeners();
  }

  void addExploredCategory(String category) {
    _exploredCategories.add(category);
    _checkDailyGoal();
    notifyListeners();
  }

  Future<void> _checkDailyGoal() async {
    final newCount = await OnboardingStorage.incrementTodaySessions();
    final goal = await OnboardingStorage.getDailyGoalSessions();
    final alreadyCelebrated = await OnboardingStorage.hasCelebratedGoalToday();
    if (goal > 0 && newCount >= goal && !alreadyCelebrated) {
      _pendingGoalCelebration = true;
      notifyListeners();
    }
  }

  void clearPendingGoalCelebration() {
    _pendingGoalCelebration = false;
  }

  Future<void> updateAchievements(int favoritesCount) async {
    _isCollector = favoritesCount >= 5;
    notifyListeners();
  }

  void updateCollectorStatus(int favoritesCount) {
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
