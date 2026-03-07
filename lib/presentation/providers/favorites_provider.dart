// lib/presentation/providers/favorites_provider.dart

import 'package:flutter/material.dart';
import '../../domain/entities/phrase_entity.dart';
import '../../domain/entities/favorite_context_entity.dart';
import '../../domain/usecases/manage_favorites_usecase.dart';
import '../../domain/usecases/context_favorites_usecases.dart';

class FavoritesProvider extends ChangeNotifier {
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;
  final IsFavoriteUseCase isFavoriteUseCase;

  final AddFavoriteContextUseCase addFavoriteContextUseCase;
  final RemoveFavoriteContextUseCase removeFavoriteContextUseCase;
  final GetFavoriteContextsUseCase getFavoriteContextsUseCase;
  final IsFavoriteContextUseCase isFavoriteContextUseCase;

  FavoritesProvider({
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.getFavoritesUseCase,
    required this.isFavoriteUseCase,
    required this.addFavoriteContextUseCase,
    required this.removeFavoriteContextUseCase,
    required this.getFavoriteContextsUseCase,
    required this.isFavoriteContextUseCase,
  });

  List<PhraseEntity> _favorites = [];
  List<FavoriteContextEntity> _favoriteContexts = [];
  bool _isLoading = false;

  List<PhraseEntity> get favorites => _favorites;
  List<FavoriteContextEntity> get favoriteContexts => _favoriteContexts;
  bool get isLoading => _isLoading;
  int get favoritesCount => _favorites.length;
  int get favoriteContextsCount => _favoriteContexts.length;
  int get totalFavoritesCount => _favorites.length + _favoriteContexts.length;

  // ========== MÉTODOS PARA FRASES ==========

  Future<void> loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    _favorites = await getFavoritesUseCase();
    _favoriteContexts = await getFavoriteContextsUseCase();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(PhraseEntity phrase) async {
    final isFav = await isFavoriteUseCase(phrase);

    if (isFav) {
      // Eliminar
      await removeFavoriteUseCase(phrase);
      _favorites.removeWhere((p) => p.id == phrase.id);
    } else {
      // Agregar
      await addFavoriteUseCase(phrase);
      // NO agregues aquí, recarga desde el repository
      await _reloadFavorites();
    }

    notifyListeners();
  }

  Future<bool> isFavorite(PhraseEntity phrase) async {
    return await isFavoriteUseCase(phrase);
  }

  // Método privado para recargar favoritos después de agregar
  Future<void> _reloadFavorites() async {
    _favorites = await getFavoritesUseCase();
  }

  // ========== MÉTODOS PARA CONTEXTOS ==========

  Future<void> toggleFavoriteContext(FavoriteContextEntity context) async {
    final isFav = await isFavoriteContextUseCase(context.id);

    if (isFav) {
      // Eliminar
      await removeFavoriteContextUseCase(context.id);
      _favoriteContexts.removeWhere((c) => c.id == context.id);
    } else {
      // Agregar
      await addFavoriteContextUseCase(context);
      // NO agregues aquí, recarga desde el repository
      await _reloadFavoriteContexts();
    }

    notifyListeners();
  }

  Future<bool> isFavoriteContext(String contextId) async {
    return await isFavoriteContextUseCase(contextId);
  }

  // Método privado para recargar contextos favoritos después de agregar
  Future<void> _reloadFavoriteContexts() async {
    _favoriteContexts = await getFavoriteContextsUseCase();
  }
}
