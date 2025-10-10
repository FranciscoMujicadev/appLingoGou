import '../repositories/stats_repository.dart';

class IncrementPhrasesViewedUseCase {
  final StatsRepository repository;

  IncrementPhrasesViewedUseCase({required this.repository});

  Future<void> call(String phraseId) async {
    await repository.incrementPhrasesViewed(phraseId);
  }
}

class IncrementShareAttemptsUseCase {
  final StatsRepository repository;

  IncrementShareAttemptsUseCase({required this.repository});

  Future<void> call() async {
    await repository.incrementShareAttempts();
  }
}

class AddExploredCategoryUseCase {
  final StatsRepository repository;

  AddExploredCategoryUseCase({required this.repository});

  Future<void> call(String category) async {
    await repository.addExploredCategory(category);
  }
}

class GetStatsUseCase {
  final StatsRepository repository;

  GetStatsUseCase({required this.repository});

  Future<Map<String, dynamic>> call() async {
    final phrasesViewed = await repository.getPhrasesViewed();
    final shareAttempts = await repository.getShareAttempts();
    final categoriesExplored = await repository.getCategoriesExplored();
    final exploredCategories = await repository.getExploredCategories();

    return {
      'phrasesViewed': phrasesViewed,
      'shareAttempts': shareAttempts,
      'categoriesExplored': categoriesExplored,
      'exploredCategories': exploredCategories,
    };
  }
}

class CheckAchievementsUseCase {
  final StatsRepository repository;
  final int favoritesCount;

  CheckAchievementsUseCase({
    required this.repository,
    required this.favoritesCount,
  });

  Future<Map<String, bool>> call() async {
    final phrasesViewed = await repository.getPhrasesViewed();
    final shareAttempts = await repository.getShareAttempts();
    final categoriesExplored = await repository.getCategoriesExplored();

    return {
      'hasFirstStep': true,
      'isCollector': favoritesCount >= 5,
      'isStudious': phrasesViewed >= 20,
      'isExplorer': categoriesExplored >= 4,
      'isSharer': shareAttempts >= 3,
      'isMaster': phrasesViewed >= 50,
    };
  }
}
