import '../entities/phrase_entity.dart';

abstract class FavoritesRepository {
  Future<void> addFavorite(PhraseEntity phrase);
  Future<void> removeFavorite(PhraseEntity phrase);
  Future<List<PhraseEntity>> getFavorites();
  Future<bool> isFavorite(PhraseEntity phrase);
  Future<void> clearAllFavorites();
}
