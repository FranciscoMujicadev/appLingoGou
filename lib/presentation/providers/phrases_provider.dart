import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/firestore_service.dart';
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
  Timer? _saveTimer;

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

  @override
  void dispose() {
    _saveTimer?.cancel();
    super.dispose();
  }

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
    if (index + 1 > prev) {
      _maxPhraseReached[_selectedCategory] = index + 1;
      _saveProgress();
      notifyListeners(); // solo cuando el progreso avanza
    }
    if (currentPhrase != null) {
      incrementPhrasesViewedUseCase(currentPhrase!.id);
    }
  }

  void initialize({String? initialCategory}) {
    loadCategories();
    final cat = (initialCategory != null &&
            _categories.any((c) => c.name == initialCategory))
        ? initialCategory
        : _selectedCategory;
    changeCategory(cat);
    _loadProgressFromPrefs();
  }

  /// Persiste el progreso en SharedPreferences y sincroniza con Firestore.
  /// Usa debounce de 2 s para no escribir en cada swipe.
  void _saveProgress() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 2), () async {
      final snapshot = Map<String, int>.from(_maxPhraseReached);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('phrase_progress', jsonEncode(snapshot));
      FirestoreService.saveProgress(snapshot);
    });
  }

  /// Carga el progreso guardado en SharedPreferences al iniciar.
  Future<void> _loadProgressFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('phrase_progress');
    if (raw == null) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        // Formato inesperado — descartar para evitar estado corrupto
        await prefs.remove('phrase_progress');
        return;
      }
      final map = decoded as Map<String, dynamic>;
      _maxPhraseReached.addAll(
        map.map((k, v) {
          final intVal = v is num
              ? v.toInt()
              : int.tryParse(v.toString()) ?? 0;
          return MapEntry(k, intVal.clamp(0, 99999));
        }),
      );
      notifyListeners();
    } catch (_) {
      // JSON corrupto → limpiar y arrancar desde cero sin crashear
      await prefs.remove('phrase_progress');
    }
  }

  /// Aplica el progreso descargado de Firestore (toma el máximo local/cloud).
  void restoreProgressFromCloud(Map<String, int> cloudProgress) {
    bool changed = false;
    for (final entry in cloudProgress.entries) {
      final current = _maxPhraseReached[entry.key] ?? 0;
      if (entry.value > current) {
        _maxPhraseReached[entry.key] = entry.value;
        changed = true;
      }
    }
    if (changed) {
      _saveProgress();
      notifyListeners();
    }
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
