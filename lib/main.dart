// lib/main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'core/injection_container.dart' as di;
import 'core/utils/onboarding_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') rethrow;
  }
  // Estas cuatro tareas son independientes entre sí y pueden correr en paralelo.
  await Future.wait([
    MobileAds.instance.initialize(),
    GoogleSignIn.instance.initialize(
      serverClientId: '697580366634-gcbr9cvu5mae5h3qr2nghns1f0b862lt.apps.googleusercontent.com',
    ),
    di.init(),
    // Limpia claves de sesión/celebración de más de 7 días para evitar
    // que SharedPreferences crezca indefinidamente con el uso diario.
    OnboardingStorage.cleanupStaleSessionKeys(),
  ]);
  runApp(const EnglishLearningApp());
}
