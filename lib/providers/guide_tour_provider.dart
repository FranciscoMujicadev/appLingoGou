import 'package:flutter/material.dart';
import '../core/utils/onboarding_storage.dart';

class GuideTourProvider extends ChangeNotifier {
  bool _isGuideTourActive = false;
  int _currentStep = 0;

  bool get isGuideTourActive => _isGuideTourActive;
  int get currentStep => _currentStep;

  final List<GuideTourStep> steps = [
    GuideTourStep(
      title: "LingoGou",
      description: "Bienvenido. Aquí siempre podrás ver el nombre de tu app favorita.",
      xAlign: 0.22,
      yAlign: 0.088,
      width: 130,
      height: 40,
      boxAtTop: false,
    ),
    GuideTourStep(
      title: "Tu Racha",
      description: "Lleva el control de tus días de estudio y progreso diario aquí.",
      xAlign: 0.65,
      yAlign: 0.088,
      width: 160,
      height: 40,
      boxAtTop: false,
    ),
    GuideTourStep(
      title: "Modo Oscuro",
      description: "Cambia entre modo claro y oscuro con este botón según prefieras.",
      xAlign: 0.89,
      yAlign: 0.088,
      width: 50,
      height: 40,
      boxAtTop: false,
    ),

    GuideTourStep(
      title: "La Palabra",
      description: "Aquí tienes la palabra principal y su pronunciación figurada.",
      xAlign: 0.5,
      yAlign: 0.24,
      width: 320,
      height: 120,
      boxAtTop: false,
    ),
    GuideTourStep(
      title: "Traducción y Uso",
      description: "Comparamos la traducción literal con el significado real que usarás.",
      xAlign: 0.5,
      yAlign: 0.48,
      width: 320,
      height: 310,
      boxAtTop: false,
    ),
    GuideTourStep(
      title: "Acciones Rápidas",
      description: "Escucha, guarda en favoritos o comparte esta palabra con amigos.",
      xAlign: 0.5,
      yAlign: 0.705,
      width: 330,
      height: 80,
      boxAtTop: true,
    ),
    GuideTourStep(
      title: "Continuar",
      description: "Cuando estés listo, pulsa aquí para pasar a la siguiente actividad del día.",
      xAlign: 0.5,
      yAlign: 0.825,
      width: 360,
      height: 60,
      boxAtTop: true,
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
  final String? key; // Opcional si usamos alineación pura
  final String title;
  final String description;
  final double xAlign;
  final double yAlign;
  final double width;
  final double height;
  final bool boxAtTop; // Si el cuadro informativo va arriba o abajo

  GuideTourStep({
    this.key,
    required this.title,
    required this.description,
    required this.xAlign,
    required this.yAlign,
    this.width = 100.0,
    this.height = 100.0,
    this.boxAtTop = false,
  });
}

