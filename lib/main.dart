// lib/main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'core/injection_container.dart' as di;
import 'core/utils/onboarding_storage.dart';

void main() async {
  // 1. Aseguramos que Flutter esté listo
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Encendemos Firebase con las opciones de tu proyecto
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') rethrow;
  }

  // 3. Ejecutamos tareas de inicio en paralelo
  // NOTA: Asegúrate de que el serverClientId coincida con el de tu consola de Google Cloud si es necesario,
  // pero para Firebase Auth estándar, a veces basta con llamar a .signIn() directamente.
  await Future.wait([
    di.init(),
    OnboardingStorage.cleanupStaleSessionKeys(),
  ]);

  runApp(const EnglishLearningApp());
}