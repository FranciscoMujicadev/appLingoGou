import 'package:flutter/material.dart';

class StatsProvider extends ChangeNotifier {
  final bool _isSharer = false;
  final bool _isMaster = false;
  bool _isCollector = false;
  final bool _isStudious = false;
  final bool _isExplorer = false;
  final bool _hasFirstStep = true; // Siempre true al abrir la app

  int _phrasesViewed = 0;
  int _shareAttempts = 0;
  final Set<String> _exploredCategories = {};

  // Getters
  bool get isSharer => _shareAttempts >= 3;
  bool get isMaster => _phrasesViewed >= 50;
  bool get isCollector => _isCollector;
  bool get isStudious => _phrasesViewed >= 20;
  bool get isExplorer => _exploredCategories.length >= 4;
  bool get hasFirstStep => _hasFirstStep;

  int get phrasesViewed => _phrasesViewed;
  int get shareAttempts => _shareAttempts;
  int get categoriesExplored => _exploredCategories.length;
  Set<String> get exploredCategories => _exploredCategories;

  // Método para cargar estadísticas guardadas
  Future<void> loadStats() async {
    // Aquí cargarías las estadísticas desde SharedPreferences
    // Por ahora dejamos valores por defecto
    notifyListeners();
  }

  // Método para incrementar frases vistas
  void incrementPhrasesViewed(String phraseId) {
    _phrasesViewed++;
    _checkAchievements();
    notifyListeners();
  }

  // Método para incrementar intentos de compartir
  void incrementShareAttempts() {
    _shareAttempts++;
    _checkAchievements();
    notifyListeners();
  }

  // Método para agregar categoría explorada
  void addExploredCategory(String category) {
    _exploredCategories.add(category);
    _checkAchievements();
    notifyListeners();
  }

  // Método para actualizar si es coleccionista
  void updateCollectorStatus(int favoritesCount) {
    _isCollector = favoritesCount >= 5;
    notifyListeners();
  }

  // Método privado para verificar logros
  void _checkAchievements() {
    // Los getters ya calculan el estado de los logros
    // Solo notificamos cambios
  }

  // Método para resetear estadísticas
  void resetStats() {
    _phrasesViewed = 0;
    _shareAttempts = 0;
    _exploredCategories.clear();
    _isCollector = false;
    notifyListeners();
  }

  Future<void> updateAchievements(int favoritesCount) async {}

  void incrementShare() {}

  getUnlockedAchievementsCount() {}
}
