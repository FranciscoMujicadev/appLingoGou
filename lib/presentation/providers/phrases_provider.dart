import 'package:flutter/material.dart';
import '../../domain/entities/phrase_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/phrases_repository.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_phrases_by_category_usecase.dart';
import '../../domain/usecases/stats_usecases.dart';
import '../../domain/usecases/get_gif_usecase.dart';
import '../../core/models/day_progress_model.dart';

class PhrasesProvider extends ChangeNotifier {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetPhrasesByCategoryUseCase getPhrasesByCategoryUseCase;
  final AddExploredCategoryUseCase addExploredCategoryUseCase;
  final IncrementPhrasesViewedUseCase incrementPhrasesViewedUseCase;
  final GetGifUseCase getGifUseCase;
  final PhrasesRepository repository;

  PhrasesProvider({
    required this.getCategoriesUseCase,
    required this.getPhrasesByCategoryUseCase,
    required this.addExploredCategoryUseCase,
    required this.incrementPhrasesViewedUseCase,
    required this.getGifUseCase,
    required this.repository,
  });

  List<CategoryEntity> _categories = [];
  String _selectedCategory = 'Día 1';
  List<PhraseEntity> _currentPhrases = [];
  int _currentIndex = 0;
  final Map<String, String> _gifCache = {};

  List<CategoryEntity> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  List<PhraseEntity> get currentPhrases => _currentPhrases;
  int get currentIndex => _currentIndex;
  PhraseEntity? get currentPhrase =>
      _currentPhrases.isEmpty || _currentIndex >= _currentPhrases.length
      ? null
      : _currentPhrases[_currentIndex];

  void loadCategories() {
    _categories = getCategoriesUseCase();
    notifyListeners();
  }

  void loadPhrasesByCategory(String category) {
    _currentPhrases = getPhrasesByCategoryUseCase(category);
    notifyListeners();
  }

  void changeCategory(String category) {
    _selectedCategory = category;
    _currentIndex = 0;
    _currentIndex = 0;
    loadPhrasesByCategory(category);
    addExploredCategoryUseCase(category);
    notifyListeners();
  }

  void changePage(int index) {
    _currentIndex = index;
    if (currentPhrase != null) {
      incrementPhrasesViewedUseCase(currentPhrase!.id);
    }
    notifyListeners();
  }

  Future<String?> getGifUrl(int index) async {
    final cacheKey = '$_selectedCategory-$index';

    if (_gifCache.containsKey(cacheKey)) {
      return _gifCache[cacheKey];
    }

    final gifUrl = await getGifUseCase(_selectedCategory, index);
    if (gifUrl != null) {
      _gifCache[cacheKey] = gifUrl;
    }

    return gifUrl;
  }

  void initialize() {
    loadCategories();
    changeCategory(_selectedCategory);
  }

  Future<Map<String, DayProgressModel>> getDaysProgress() async {
    return await repository.getDaysProgress();
  }

  Future<void> markPhraseAsUsed(String dayId, int phraseIndex) async {
    await repository.markPhraseAsUsed(dayId, phraseIndex);
    notifyListeners();
  }

  Future<String> getInitialDay() async {
    return await repository.getInitialDay();
  }

  String getDailyChallenge(String day) {
    return repository.getDailyChallenge(day);
  }

  // NUEVOS MÉTODOS AGREGADOS:

  /// Completa el día actual y desbloquea el siguiente
  Future<void> completeDayAndUnlockNext(String currentDay) async {
    await repository.completeDayAndUnlockNext(currentDay);
    notifyListeners();
  }

  /// Confirma que el usuario completó el reto del día anterior
  Future<void> confirmDayChallenge(String dayId) async {
    await repository.confirmDayChallenge(dayId);
    notifyListeners();
  }
}
