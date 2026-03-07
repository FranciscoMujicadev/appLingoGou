import 'package:flutter/material.dart';
import '../../domain/entities/phrase_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/phrases_repository.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_phrases_by_category_usecase.dart';
import '../../domain/usecases/stats_usecases.dart';
import '../../core/models/day_progress_model.dart';

class PhrasesProvider extends ChangeNotifier {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetPhrasesByCategoryUseCase getPhrasesByCategoryUseCase;
  final AddExploredCategoryUseCase addExploredCategoryUseCase;
  final IncrementPhrasesViewedUseCase incrementPhrasesViewedUseCase;
  final PhrasesRepository repository;

  PhrasesProvider({
    required this.getCategoriesUseCase,
    required this.getPhrasesByCategoryUseCase,
    required this.addExploredCategoryUseCase,
    required this.incrementPhrasesViewedUseCase,
    required this.repository,
  });

  List<CategoryEntity> _categories = [];
  String _selectedCategory = 'Nivel 1';
  List<PhraseEntity> _currentPhrases = [];
  int _currentIndex = 0;
  final Map<String, int> _maxPhraseReached = {};

  List<CategoryEntity> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  List<PhraseEntity> get currentPhrases => _currentPhrases;
  int get currentIndex => _currentIndex;
  int getProgressForCategory(String cat) => _maxPhraseReached[cat] ?? 0;
  PhraseEntity? get currentPhrase =>
      _currentPhrases.isEmpty || _currentIndex >= _currentPhrases.length
      ? null
      : _currentPhrases[_currentIndex];

  // 🆕 NUEVO: Obtener número total de niveles dinámicamente
  int get totalDays => _categories.length;

  // 🆕 NUEVO: Obtener número de nivel actual
  int get currentDayNumber {
    final match = RegExp(r'\d+').firstMatch(_selectedCategory);
    return match != null ? int.parse(match.group(0)!) : 1;
  }

  // 🆕 NUEVO: Verificar si es el último día
  bool get isLastDay => currentDayNumber >= totalDays;

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
    loadPhrasesByCategory(category);
    addExploredCategoryUseCase(category);
    notifyListeners();
  }

  void changePage(int index) {
    _currentIndex = index;
    final prev = _maxPhraseReached[_selectedCategory] ?? 0;
    if (index + 1 > prev) _maxPhraseReached[_selectedCategory] = index + 1;
    if (currentPhrase != null) {
      incrementPhrasesViewedUseCase(currentPhrase!.id);
    }
    notifyListeners();
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

  Future<void> completeDayAndUnlockNext(String currentDay) async {
    await repository.completeDayAndUnlockNext(currentDay);
    notifyListeners();
  }

  Future<void> confirmDayChallenge(String dayId) async {
    await repository.confirmDayChallenge(dayId);
    notifyListeners();
  }
}
