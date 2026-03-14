// lib/presentation/providers/auth_provider.dart

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  User? _user;
  bool _initialized = false;

  AuthProvider() {
    _user = _auth.currentUser;
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  bool get isSignedIn => _user != null;
  User? get user => _user;

  /// Inicializa GoogleSignIn (debe llamarse una vez).
  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    try {
      await _googleSignIn.initialize();
      _initialized = true;
    } catch (e) {
      debugPrint('GoogleSignIn.initialize error: $e');
    }
  }

  /// Inicia sesión con Google (google_sign_in 7.x API)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _ensureInitialized();

      final googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      final userCredential = await _auth.signInWithCredential(credential);
      _user = userCredential.user;
      notifyListeners();
      return userCredential;
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      return null;
    }
  }

  /// Cierra sesión
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
