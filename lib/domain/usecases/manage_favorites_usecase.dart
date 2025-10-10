import '../entities/phrase_entity.dart';
import '../repositories/favorites_repository.dart';

class AddFavoriteUseCase {
  final FavoritesRepository repository;

  AddFavoriteUseCase({required this.repository});

  Future<void> call(PhraseEntity phrase) async {
    await repository.addFavorite(phrase);
  }
}

class RemoveFavoriteUseCase {
  final FavoritesRepository repository;

  RemoveFavoriteUseCase({required this.repository});

  Future<void> call(PhraseEntity phrase) async {
    await repository.removeFavorite(phrase);
  }
}

class GetFavoritesUseCase {
  final FavoritesRepository repository;

  GetFavoritesUseCase({required this.repository});

  Future<List<PhraseEntity>> call() async {
    return await repository.getFavorites();
  }
}

class IsFavoriteUseCase {
  final FavoritesRepository repository;

  IsFavoriteUseCase({required this.repository});

  Future<bool> call(PhraseEntity phrase) async {
    return await repository.isFavorite(phrase);
  }
}
