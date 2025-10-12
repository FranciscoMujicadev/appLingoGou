// lib/data/repositories/favorites_repository_impl.dart

import '../../domain/entities/phrase_entity.dart';
import '../../domain/entities/favorite_context_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/local_storage_datasource.dart';
import '../../core/models/phrase_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final LocalStorageDataSource localDataSource;
  List<PhraseEntity> _cachedFavorites = [];
  List<FavoriteContextEntity> _cachedFavoriteContexts = [];

  FavoritesRepositoryImpl({required this.localDataSource});

  // ========== MÉTODOS PARA FRASES ==========

  @override
  Future<void> addFavorite(PhraseEntity phrase) async {
    if (!_cachedFavorites.any((p) => p.id == phrase.id)) {
      _cachedFavorites.add(phrase);
      await _saveFavorites();
    }
  }

  @override
  Future<void> removeFavorite(PhraseEntity phrase) async {
    _cachedFavorites.removeWhere((p) => p.id == phrase.id);
    await _saveFavorites();
  }

  @override
  Future<List<PhraseEntity>> getFavorites() async {
    if (_cachedFavorites.isEmpty) {
      final models = await localDataSource.loadFavorites();
      _cachedFavorites = models.map((model) => model.toEntity()).toList();
    }
    return _cachedFavorites;
  }

  @override
  Future<bool> isFavorite(PhraseEntity phrase) async {
    if (_cachedFavorites.isEmpty) {
      await getFavorites();
    }
    return _cachedFavorites.any((p) => p.id == phrase.id);
  }

  @override
  Future<void> clearAllFavorites() async {
    _cachedFavorites.clear();
    await localDataSource.saveFavorites([]);
  }

  Future<void> _saveFavorites() async {
    final models = _cachedFavorites
        .map((entity) => Phrase.fromEntity(entity))
        .toList();
    await localDataSource.saveFavorites(models);
  }

  // ========== MÉTODOS PARA CONTEXTOS ==========

  @override
  Future<void> addFavoriteContext(FavoriteContextEntity context) async {
    if (!_cachedFavoriteContexts.any((c) => c.id == context.id)) {
      _cachedFavoriteContexts.add(context);
      await _saveFavoriteContexts();
    }
  }

  @override
  Future<void> removeFavoriteContext(String contextId) async {
    _cachedFavoriteContexts.removeWhere((c) => c.id == contextId);
    await _saveFavoriteContexts();
  }

  @override
  Future<List<FavoriteContextEntity>> getFavoriteContexts() async {
    if (_cachedFavoriteContexts.isEmpty) {
      _cachedFavoriteContexts = await localDataSource.loadFavoriteContexts();
    }
    return _cachedFavoriteContexts;
  }

  @override
  Future<bool> isFavoriteContext(String contextId) async {
    if (_cachedFavoriteContexts.isEmpty) {
      await getFavoriteContexts();
    }
    return _cachedFavoriteContexts.any((c) => c.id == contextId);
  }

  @override
  Future<void> clearAllFavoriteContexts() async {
    _cachedFavoriteContexts.clear();
    await localDataSource.saveFavoriteContexts([]);
  }

  Future<void> _saveFavoriteContexts() async {
    await localDataSource.saveFavoriteContexts(_cachedFavoriteContexts);
  }
}
