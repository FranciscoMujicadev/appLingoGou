import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  FlutterTts? _flutterTts;
  bool _isInitialized = false;
  bool _isInitializing = false;

  Future<void> initialize() async {
    // Evitar múltiples inicializaciones
    if (_isInitialized || _isInitializing) return;

    _isInitializing = true;

    try {
      _flutterTts = FlutterTts();

      // Configuración básica para inglés
      await _flutterTts!.setLanguage('en-US');
      await _flutterTts!.setSpeechRate(0.45);
      await _flutterTts!.setPitch(1.0);
      await _flutterTts!.setVolume(1.0);

      _isInitialized = true;
      print('✅ TTS inicializado correctamente');
    } catch (e) {
      print('❌ Error al inicializar TTS: $e');
      _isInitialized = false;
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> speak(String text) async {
    try {
      if (!_isInitialized) {
        await initialize();
      }

      if (_flutterTts == null) return;

      await _flutterTts!.stop();
      await _flutterTts!.setLanguage('en-US');
      await _flutterTts!.speak(text);

      print('🔊 Reproduciendo: $text');
    } catch (e) {
      print('❌ Error al reproducir: $e');
    }
  }

  Future<void> speakSlow(String text) async {
    try {
      if (!_isInitialized) await initialize();
      if (_flutterTts == null) return;
      await _flutterTts!.stop();
      await _flutterTts!.setLanguage('en-US');
      await _flutterTts!.setSpeechRate(0.25);
      await _flutterTts!.speak(text);
      await _flutterTts!.setSpeechRate(0.45);
    } catch (e) {
      print('❌ Error al reproducir lento: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts?.stop();
    } catch (e) {
      print('❌ Error al detener: $e');
    }
  }

  void dispose() {
    try {
      _flutterTts?.stop();
    } catch (e) {
      print('Error en dispose: $e');
    }
  }
}
