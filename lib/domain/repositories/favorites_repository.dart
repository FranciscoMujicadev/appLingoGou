// lib/domain/repositories/favorites_repository.dart

import '../entities/phrase_entity.dart';
import '../entities/favorite_context_entity.dart';

abstract class FavoritesRepository {
  // Métodos para frases completas
  Future<void> addFavorite(PhraseEntity phrase);
  Future<void> removeFavorite(PhraseEntity phrase);
  Future<List<PhraseEntity>> getFavorites();
  Future<bool> isFavorite(PhraseEntity phrase);
  Future<void> clearAllFavorites();

  // Métodos para contextos/ejemplos
  Future<void> addFavoriteContext(FavoriteContextEntity context);
  Future<void> removeFavoriteContext(String contextId);
  Future<List<FavoriteContextEntity>> getFavoriteContexts();
  Future<bool> isFavoriteContext(String contextId);
  Future<void> clearAllFavoriteContexts();
}
