import 'package:flutter/material.dart';
import '../../domain/entities/phrase_entity.dart';
import '../../domain/usecases/manage_favorites_usecase.dart';

class FavoritesProvider extends ChangeNotifier {
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;
  final IsFavoriteUseCase isFavoriteUseCase;

  FavoritesProvider({
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.getFavoritesUseCase,
    required this.isFavoriteUseCase,
  });

  List<PhraseEntity> _favorites = [];
  bool _isLoading = false;

  List<PhraseEntity> get favorites => _favorites;
  bool get isLoading => _isLoading;
  int get favoritesCount => _favorites.length;

  Future<void> loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    _favorites = await getFavoritesUseCase();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(PhraseEntity phrase) async {
    final isFav = await isFavoriteUseCase(phrase);

    if (isFav) {
      await removeFavoriteUseCase(phrase);
      _favorites.removeWhere((p) => p.id == phrase.id);
    } else {
      await addFavoriteUseCase(phrase);
      _favorites.add(phrase);
    }

    notifyListeners();
  }

  Future<bool> isFavorite(PhraseEntity phrase) async {
    return await isFavoriteUseCase(phrase);
  }
}
