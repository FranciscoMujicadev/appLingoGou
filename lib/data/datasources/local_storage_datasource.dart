// lib/data/datasources/local_storage_datasource.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/models/phrase_model.dart';
import '../../domain/entities/favorite_context_entity.dart';
import '../models/user_stats_model.dart';

abstract class LocalStorageDataSource {
  Future<void> saveFavorites(List<Phrase> phrases);
  Future<List<Phrase>> loadFavorites();
  Future<void> saveUserStats(UserStatsModel stats);
  Future<UserStatsModel> loadUserStats();
  Future<void> clearAllData();

  // Métodos para contextos favoritos
  Future<void> saveFavoriteContexts(List<FavoriteContextEntity> contexts);
  Future<List<FavoriteContextEntity>> loadFavoriteContexts();
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
    await sharedPreferences.remove('favoriteContexts');
    await sharedPreferences.remove('phrasesViewed');
    await sharedPreferences.remove('shareAttempts');
    await sharedPreferences.remove('exploredCategories');
    await sharedPreferences.remove('viewedPhrases');
  }

  // ========== MÉTODOS PARA CONTEXTOS FAVORITOS ==========

  @override
  Future<void> saveFavoriteContexts(
    List<FavoriteContextEntity> contexts,
  ) async {
    final contextsData = contexts.map((c) => c.toJson()).toList();
    await sharedPreferences.setString(
      'favoriteContexts',
      jsonEncode(contextsData),
    );
  }

  @override
  Future<List<FavoriteContextEntity>> loadFavoriteContexts() async {
    final contextsJson = sharedPreferences.getString('favoriteContexts');
    if (contextsJson == null) return [];

    try {
      final List<dynamic> contextsData = jsonDecode(contextsJson);
      return contextsData
          .map((json) => FavoriteContextEntity.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
