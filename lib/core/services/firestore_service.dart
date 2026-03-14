// lib/core/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  static final _firestore = FirebaseFirestore.instance;

  static String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  /// Carga todos los datos del usuario desde Firestore.
  /// Retorna null si no hay documento.
  static Future<Map<String, dynamic>?> loadUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) return null;
      return doc.data();
    } catch (e) {
      debugPrint('FirestoreService.loadUserData error: $e');
      return null;
    }
  }

  /// Guarda el progreso de frases (Map<categoryName, maxPage>).
  static Future<void> saveProgress(Map<String, int> progress) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await _firestore.collection('users').doc(uid).set(
        {'progress': progress},
        SetOptions(merge: true),
      );
    } catch (e) {
      debugPrint('FirestoreService.saveProgress error: $e');
    }
  }

  /// Guarda estadísticas del usuario.
  static Future<void> saveStats({
    required int phrasesViewed,
    required int shareAttempts,
    required Set<String> exploredCategories,
  }) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await _firestore.collection('users').doc(uid).set(
        {
          'stats': {
            'phrasesViewed': phrasesViewed,
            'shareAttempts': shareAttempts,
            'exploredCategories': exploredCategories.toList(),
          },
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      debugPrint('FirestoreService.saveStats error: $e');
    }
  }

  /// Guarda las listas de favoritos (frases y contextos).
  static Future<void> saveFavorites({
    required List<Map<String, dynamic>> phrases,
    required List<Map<String, dynamic>> contexts,
  }) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await _firestore.collection('users').doc(uid).set(
        {
          'favoritePhrases': phrases,
          'favoriteContexts': contexts,
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      debugPrint('FirestoreService.saveFavorites error: $e');
    }
  }
}
