import 'package:flutter/material.dart';
import '../core/utils/onboarding_storage.dart';

class GuideTourProvider extends ChangeNotifier {
  bool _isGuideTourActive = false;
  int _currentStep = 0;

  bool get isGuideTourActive => _isGuideTourActive;
  int get currentStep => _currentStep;

  final List<GuideTourStep> steps = [
    // 1. Nombre del curso / título de la aplicación
    GuideTourStep(
      key: 'app_title',
      title: 'Bienvenido a LingoGou',
      description: 'El nombre de tu curso de idiomas.',
      xAlign: 0.2,
      yAlign: 0.10,
    ),
    // 2. Indicador de progreso general
    GuideTourStep(
      key: 'progress_indicator',
      title: 'Tu progreso general',
      description: 'En este número ves tu avance en el nivel actual.',
      xAlign: 0.8,
      yAlign: 0.15,
    ),
    // 3. Selección del día
    GuideTourStep(
      key: 'days_selector',
      title: 'Selección del Nivel',
      description: 'Cambia entre las lecciones diarias.',
      xAlign: 0.5,
      yAlign: 0.15,
    ),
    // 4. Tarjeta de frase principal
    GuideTourStep(
      key: 'phrase_card',
      title: 'Expresión Principal',
      description: 'La frase o palabra clave a aprender hoy.',
      xAlign: 0.5,
      yAlign: 0.50,
    ),
    // 5a. Traducción literal
    GuideTourStep(
      key: 'literal_meaning',
      title: 'Traducción Literal',
      description: 'Cómo se traduce palabra por palabra.',
      xAlign: 0.5,
      yAlign: 0.60,
    ),
    // 5b. Significado real/contextual
    GuideTourStep(
      key: 'real_meaning',
      title: 'Significado real',
      description: 'Cómo se debe usar en la conversación real.',
      xAlign: 0.5,
      yAlign: 0.70,
    ),
    // 6a. Botón de audio
    GuideTourStep(
      key: 'audio_button',
      title: 'Escucha la pronunciación',
      description: 'Reproduce la frase con voz de nativo.',
      xAlign: 0.25,
      yAlign: 0.85,
    ),
    // 6b. Botón de favoritos
    GuideTourStep(
      key: 'favorite_button',
      title: 'Añade a Favoritos',
      description: 'Guarda esta frase para repasarla más tarde.',
      xAlign: 0.50,
      yAlign: 0.85,
    ),
    // 6c. Botón de compartir
    GuideTourStep(
      key: 'share_button',
      title: 'Comparte con otros',
      description: 'Envía la frase por WhatsApp, email, etc.',
      xAlign: 0.75,
      yAlign: 0.85,
    ),
    // 7. Navegación global
    GuideTourStep(
      key: 'navigation_bar',
      title: 'Navegación global',
      description: 'Explora lecciones, historias y tus frases guardadas.',
      xAlign: 0.5,
      yAlign: 0.95,
    ),
  ];

  Future<void> initGuideTour() async {
    final hasSeenGuide = await OnboardingStorage.hasSeenGuideTour();
    if (!hasSeenGuide) {
      _isGuideTourActive = true;
      notifyListeners();
    }
  }

  void nextStep() {
    if (_currentStep < steps.length - 1) {
      _currentStep++;
      notifyListeners();
    } else {
      finishGuideTour();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void skipGuideTour() {
    finishGuideTour();
  }

  void finishGuideTour() async {
    _isGuideTourActive = false;
    _currentStep = 0;
    await OnboardingStorage.setGuideTourCompleted();
    notifyListeners();
  }

  void resetGuideTour() {
    _currentStep = 0;
    OnboardingStorage.resetGuideTour();
  }
}

class GuideTourStep {
  final String key;
  final String title;
  final String description;
  final double xAlign;
  final double yAlign;

  GuideTourStep({
    required this.key,
    required this.title,
    required this.description,
    required this.xAlign,
    required this.yAlign,
  });
}
