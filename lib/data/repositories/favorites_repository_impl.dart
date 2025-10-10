import '../../domain/entities/phrase_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/local_storage_datasource.dart';
import '../../core/models/phrase_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final LocalStorageDataSource localDataSource;
  List<PhraseEntity> _cachedFavorites = [];

  FavoritesRepositoryImpl({required this.localDataSource});

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
}
