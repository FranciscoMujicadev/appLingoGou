abstract class StatsRepository {
  Future<void> incrementPhrasesViewed(String phraseId);
  Future<void> incrementShareAttempts();
  Future<void> addExploredCategory(String category);
  Future<int> getPhrasesViewed();
  Future<int> getShareAttempts();
  Future<int> getCategoriesExplored();
  Future<Set<String>> getExploredCategories();
  Future<void> resetStats();
}
