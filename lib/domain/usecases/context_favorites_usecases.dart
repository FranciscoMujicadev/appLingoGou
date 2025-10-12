// lib/domain/usecases/context_favorites_usecases.dart

import '../entities/favorite_context_entity.dart';
import '../repositories/favorites_repository.dart';

class AddFavoriteContextUseCase {
  final FavoritesRepository repository;

  AddFavoriteContextUseCase({required this.repository});

  Future<void> call(FavoriteContextEntity context) async {
    await repository.addFavoriteContext(context);
  }
}

class RemoveFavoriteContextUseCase {
  final FavoritesRepository repository;

  RemoveFavoriteContextUseCase({required this.repository});

  Future<void> call(String contextId) async {
    await repository.removeFavoriteContext(contextId);
  }
}

class GetFavoriteContextsUseCase {
  final FavoritesRepository repository;

  GetFavoriteContextsUseCase({required this.repository});

  Future<List<FavoriteContextEntity>> call() async {
    return await repository.getFavoriteContexts();
  }
}

class IsFavoriteContextUseCase {
  final FavoritesRepository repository;

  IsFavoriteContextUseCase({required this.repository});

  Future<bool> call(String contextId) async {
    return await repository.isFavoriteContext(contextId);
  }
}
