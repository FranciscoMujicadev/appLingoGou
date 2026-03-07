// lib/core/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Data sources
import '../data/datasources/local_storage_datasource.dart';
import '../data/datasources/phrases_datasource.dart';

// Repositories
import '../data/repositories/phrases_repository_impl.dart';
import '../data/repositories/favorites_repository_impl.dart';
import '../data/repositories/stats_repository_impl.dart';
import '../domain/repositories/phrases_repository.dart';
import '../domain/repositories/favorites_repository.dart';
import '../domain/repositories/stats_repository.dart';

// Use cases
import '../domain/usecases/get_categories_usecase.dart';
import '../domain/usecases/get_phrases_by_category_usecase.dart';
import '../domain/usecases/manage_favorites_usecase.dart';
import '../domain/usecases/context_favorites_usecases.dart';
import '../domain/usecases/stats_usecases.dart';

// Providers
import '../presentation/providers/phrases_provider.dart';
import '../presentation/providers/favorites_provider.dart';
import '../presentation/providers/stats_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ============ External ============
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // ============ Data Sources ============
  sl.registerLazySingleton<LocalStorageDataSource>(
    () => LocalStorageDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<PhrasesDataSource>(() => PhrasesDataSourceImpl());

  // ============ Repositories ============
  sl.registerLazySingleton<PhrasesRepository>(
    () => PhrasesRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<StatsRepository>(
    () => StatsRepositoryImpl(localDataSource: sl()),
  );

  // ============ Use Cases ============

  // Phrases
  sl.registerLazySingleton(() => GetCategoriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPhrasesByCategoryUseCase(repository: sl()));

  // Favorites - Frases
  sl.registerLazySingleton(() => AddFavoriteUseCase(repository: sl()));
  sl.registerLazySingleton(() => RemoveFavoriteUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetFavoritesUseCase(repository: sl()));
  sl.registerLazySingleton(() => IsFavoriteUseCase(repository: sl()));

  // Favorites - Contextos
  sl.registerLazySingleton(() => AddFavoriteContextUseCase(repository: sl()));
  sl.registerLazySingleton(
    () => RemoveFavoriteContextUseCase(repository: sl()),
  );
  sl.registerLazySingleton(() => GetFavoriteContextsUseCase(repository: sl()));
  sl.registerLazySingleton(() => IsFavoriteContextUseCase(repository: sl()));

  // Stats
  sl.registerLazySingleton(
    () => IncrementPhrasesViewedUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => IncrementShareAttemptsUseCase(repository: sl()),
  );
  sl.registerLazySingleton(() => AddExploredCategoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetStatsUseCase(repository: sl()));
  sl.registerLazySingleton(
    () => CheckAchievementsUseCase(repository: sl(), favoritesCount: 0),
  );

  // ============ Providers ============
  sl.registerFactory(
    () => PhrasesProvider(
      getCategoriesUseCase: sl(),
      getPhrasesByCategoryUseCase: sl(),
      addExploredCategoryUseCase: sl(),
      incrementPhrasesViewedUseCase: sl(),
      repository: sl(),
    ),
  );

  sl.registerFactory(
    () => FavoritesProvider(
      addFavoriteUseCase: sl(),
      removeFavoriteUseCase: sl(),
      getFavoritesUseCase: sl(),
      isFavoriteUseCase: sl(),
      addFavoriteContextUseCase: sl(),
      removeFavoriteContextUseCase: sl(),
      getFavoriteContextsUseCase: sl(),
      isFavoriteContextUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => StatsProvider(getStatsUseCase: sl(), checkAchievementsUseCase: sl()),
  );
}
