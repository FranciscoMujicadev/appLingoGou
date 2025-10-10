import '../../domain/repositories/stats_repository.dart';
import '../datasources/local_storage_datasource.dart';
import '../models/user_stats_model.dart';

class StatsRepositoryImpl implements StatsRepository {
  final LocalStorageDataSource localDataSource;
  UserStatsModel? _cachedStats;

  StatsRepositoryImpl({required this.localDataSource});

  Future<UserStatsModel> _getStats() async {
    _cachedStats ??= await localDataSource.loadUserStats();
    return _cachedStats!;
  }

  @override
  Future<void> incrementPhrasesViewed(String phraseId) async {
    final stats = await _getStats();
    if (!stats.viewedPhrases.contains(phraseId)) {
      final newViewedPhrases = Set<String>.from(stats.viewedPhrases)
        ..add(phraseId);
      _cachedStats = stats.copyWith(
        phrasesViewed: stats.phrasesViewed + 1,
        viewedPhrases: newViewedPhrases,
      );
      await localDataSource.saveUserStats(_cachedStats!);
    }
  }

  @override
  Future<void> incrementShareAttempts() async {
    final stats = await _getStats();
    _cachedStats = stats.copyWith(shareAttempts: stats.shareAttempts + 1);
    await localDataSource.saveUserStats(_cachedStats!);
  }

  @override
  Future<void> addExploredCategory(String category) async {
    final stats = await _getStats();
    if (!stats.exploredCategories.contains(category)) {
      final newCategories = Set<String>.from(stats.exploredCategories)
        ..add(category);
      _cachedStats = stats.copyWith(exploredCategories: newCategories);
      await localDataSource.saveUserStats(_cachedStats!);
    }
  }

  @override
  Future<int> getPhrasesViewed() async {
    final stats = await _getStats();
    return stats.phrasesViewed;
  }

  @override
  Future<int> getShareAttempts() async {
    final stats = await _getStats();
    return stats.shareAttempts;
  }

  @override
  Future<int> getCategoriesExplored() async {
    final stats = await _getStats();
    return stats.exploredCategories.length;
  }

  @override
  Future<Set<String>> getExploredCategories() async {
    final stats = await _getStats();
    return stats.exploredCategories;
  }

  @override
  Future<void> resetStats() async {
    _cachedStats = UserStatsModel.empty();
    await localDataSource.saveUserStats(_cachedStats!);
  }
}
