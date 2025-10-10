import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/models/phrase_model.dart';
import '../models/user_stats_model.dart';

abstract class LocalStorageDataSource {
  Future<void> saveFavorites(List<Phrase> phrases);
  Future<List<Phrase>> loadFavorites();
  Future<void> saveUserStats(UserStatsModel stats);
  Future<UserStatsModel> loadUserStats();
  Future<void> clearAllData();
}

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  final SharedPreferences sharedPreferences;

  LocalStorageDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveFavorites(List<Phrase> phrases) async {
    final favoritesData = phrases.map((p) => p.toJson()).toList();
    await sharedPreferences.setString('favorites', jsonEncode(favoritesData));
  }

  @override
  Future<List<Phrase>> loadFavorites() async {
    final favoritesJson = sharedPreferences.getString('favorites');
    if (favoritesJson == null) return [];

    try {
      final List<dynamic> favoritesData = jsonDecode(favoritesJson);
      return favoritesData.map((json) => Phrase.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveUserStats(UserStatsModel stats) async {
    await sharedPreferences.setInt('phrasesViewed', stats.phrasesViewed);
    await sharedPreferences.setInt('shareAttempts', stats.shareAttempts);
    await sharedPreferences.setStringList(
      'exploredCategories',
      stats.exploredCategories.toList(),
    );
    await sharedPreferences.setStringList(
      'viewedPhrases',
      stats.viewedPhrases.toList(),
    );
  }

  @override
  Future<UserStatsModel> loadUserStats() async {
    final phrasesViewed = sharedPreferences.getInt('phrasesViewed') ?? 0;
    final shareAttempts = sharedPreferences.getInt('shareAttempts') ?? 0;
    final exploredCategories = Set<String>.from(
      sharedPreferences.getStringList('exploredCategories') ?? [],
    );
    final viewedPhrases = Set<String>.from(
      sharedPreferences.getStringList('viewedPhrases') ?? [],
    );

    return UserStatsModel(
      phrasesViewed: phrasesViewed,
      shareAttempts: shareAttempts,
      exploredCategories: exploredCategories,
      viewedPhrases: viewedPhrases,
    );
  }

  @override
  Future<void> clearAllData() async {
    await sharedPreferences.remove('favorites');
    await sharedPreferences.remove('phrasesViewed');
    await sharedPreferences.remove('shareAttempts');
    await sharedPreferences.remove('exploredCategories');
    await sharedPreferences.remove('viewedPhrases');
  }
}
