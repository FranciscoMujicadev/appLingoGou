// lib/presentation/screens/main_navigation_screen.dart

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/injection_container.dart' as di;
import '../../core/services/firestore_service.dart';
import '../../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../providers/phrases_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/stats_provider.dart';
import '../../core/models/module_model.dart';
import 'dashboard_screen.dart';
import 'module_selection_screen.dart';
import 'home_screen.dart';
import 'stories_page.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final String? initialCategory;
  const MainNavigationScreen({super.key, this.initialCategory});

  // Controlador global para navegar desde cualquier pantalla hija.
  static void Function(int index)? _goToStatic;
  static void Function()? _clearModuleStatic;
  static AppModule? Function()? _getModuleStatic;

  /// Cambia la pestaña activa (0=Home/Dashboard, 1=Learn, 2=Stories, 3=Fav, 4=Perfil).
  static void goTo(int index) => _goToStatic?.call(index);

  /// Deselecciona el módulo actual (vuelve al selector de módulos).
  static void clearModule() => _clearModuleStatic?.call();

  /// Devuelve el módulo seleccionado (o null si no hay).
  static AppModule? get currentModule => _getModuleStatic?.call();

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  AppModule? _selectedModule;
  late AuthProvider _authProvider;
  bool _prevSignedIn = false;

  void _goTo(int index) => setState(() => _currentIndex = index);

  @override
  void initState() {
    super.initState();
    MainNavigationScreen._goToStatic = _goTo;
    MainNavigationScreen._clearModuleStatic =
        () => setState(() => _selectedModule = null);
    MainNavigationScreen._getModuleStatic = () => _selectedModule;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authProvider = context.read<AuthProvider>();
      _prevSignedIn = _authProvider.isSignedIn;
      _authProvider.addListener(_onAuthChanged);
      if (_authProvider.isSignedIn) _restoreFromCloud();
    });

  }

  @override
  void dispose() {
    MainNavigationScreen._goToStatic = null;
    MainNavigationScreen._clearModuleStatic = null;
    MainNavigationScreen._getModuleStatic = null;
    _authProvider.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    final isSignedIn = _authProvider.isSignedIn;
    if (isSignedIn && !_prevSignedIn) {
      _restoreFromCloud();
    }
    _prevSignedIn = isSignedIn;
  }

  // ─── Restaurar datos desde Firestore al iniciar sesión ──────────────────

  Future<void> _restoreFromCloud() async {
    if (!mounted) return;
    final uid = context.read<AuthProvider>().user?.uid;
    final statsProvider = di.sl<StatsProvider>();
    final favoritesProvider = di.sl<FavoritesProvider>();
    final phrasesProvider = di.sl<PhrasesProvider>();
    if (uid == null) return;

    final cloudData = await FirestoreService.loadUserData(uid);
    if (cloudData == null) {
      // Primera vez: subir datos locales a la nube
      _pushLocalToCloud();
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    // ── Merge stats ────────────────────────────────────────────────────────
    final cloudStats = cloudData['stats'] as Map<String, dynamic>?;
    int mergedPhrases = prefs.getInt('phrasesViewed') ?? 0;
    int mergedShares = prefs.getInt('shareAttempts') ?? 0;
    Set<String> mergedCategories = Set<String>.from(
      prefs.getStringList('exploredCategories') ?? [],
    );
    if (cloudStats != null) {
      mergedPhrases = max(
        mergedPhrases,
        (cloudStats['phrasesViewed'] as int?) ?? 0,
      );
      mergedShares = max(
        mergedShares,
        (cloudStats['shareAttempts'] as int?) ?? 0,
      );
      mergedCategories.addAll(
        (cloudStats['exploredCategories'] as List?)?.cast<String>() ?? [],
      );
    }

    // ── Merge progress ─────────────────────────────────────────────────────
    final cloudProgress = cloudData['progress'] as Map<String, dynamic>?;
    final localProgressJson = prefs.getString('phrase_progress');
    Map<String, int> mergedProgress = {};
    if (localProgressJson != null) {
      mergedProgress = (jsonDecode(localProgressJson) as Map).map(
        (k, v) => MapEntry(k as String, (v as num).toInt()),
      );
    }
    if (cloudProgress != null) {
      for (final e in cloudProgress.entries) {
        final cloudVal = (e.value as num).toInt();
        mergedProgress[e.key] = max(mergedProgress[e.key] ?? 0, cloudVal);
      }
    }

    // ── Merge favorites ────────────────────────────────────────────────────
    List<Map<String, dynamic>> mergedPhrasesFav = [];
    final localFavJson = prefs.getString('favorites');
    if (localFavJson != null) {
      mergedPhrasesFav =
          (jsonDecode(localFavJson) as List).cast<Map<String, dynamic>>();
    }
    final cloudPhrasesFav =
        (cloudData['favoritePhrases'] as List?)?.cast<Map<String, dynamic>>() ??
        [];
    final localPhraseIds =
        mergedPhrasesFav.map((p) => p['id'] as String).toSet();
    for (final p in cloudPhrasesFav) {
      if (!localPhraseIds.contains(p['id'] as String)) mergedPhrasesFav.add(p);
    }

    List<Map<String, dynamic>> mergedContextsFav = [];
    final localCtxJson = prefs.getString('favoriteContexts');
    if (localCtxJson != null) {
      mergedContextsFav =
          (jsonDecode(localCtxJson) as List).cast<Map<String, dynamic>>();
    }
    final cloudContextsFav =
        (cloudData['favoriteContexts'] as List?)
            ?.cast<Map<String, dynamic>>() ??
        [];
    final localCtxIds =
        mergedContextsFav.map((c) => c['id'] as String).toSet();
    for (final c in cloudContextsFav) {
      if (!localCtxIds.contains(c['id'] as String)) mergedContextsFav.add(c);
    }

    // ── Guardar merged en SharedPreferences ────────────────────────────────
    await prefs.setInt('phrasesViewed', mergedPhrases);
    await prefs.setInt('shareAttempts', mergedShares);
    await prefs.setStringList('exploredCategories', mergedCategories.toList());
    await prefs.setString('phrase_progress', jsonEncode(mergedProgress));
    await prefs.setString('favorites', jsonEncode(mergedPhrasesFav));
    await prefs.setString('favoriteContexts', jsonEncode(mergedContextsFav));

    if (!mounted) return;

    // ── Actualizar providers en memoria ────────────────────────────────────
    statsProvider.restoreFromCloud(
      phrasesViewed: mergedPhrases,
      shareAttempts: mergedShares,
      exploredCategories: mergedCategories,
    );
    await favoritesProvider.loadFavorites();
    phrasesProvider.restoreProgressFromCloud(mergedProgress);
  }

  Future<void> _pushLocalToCloud() async {
    final prefs = await SharedPreferences.getInstance();

    FirestoreService.saveStats(
      phrasesViewed: prefs.getInt('phrasesViewed') ?? 0,
      shareAttempts: prefs.getInt('shareAttempts') ?? 0,
      exploredCategories: Set<String>.from(
        prefs.getStringList('exploredCategories') ?? [],
      ),
    );

    final progressJson = prefs.getString('phrase_progress');
    if (progressJson != null) {
      FirestoreService.saveProgress(
        (jsonDecode(progressJson) as Map).map(
          (k, v) => MapEntry(k as String, (v as num).toInt()),
        ),
      );
    }

    final favJson = prefs.getString('favorites');
    final ctxJson = prefs.getString('favoriteContexts');
    FirestoreService.saveFavorites(
      phrases:
          favJson != null
              ? (jsonDecode(favJson) as List).cast<Map<String, dynamic>>()
              : [],
      contexts:
          ctxJson != null
              ? (jsonDecode(ctxJson) as List).cast<Map<String, dynamic>>()
              : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<PhrasesProvider>()
              ..initialize(initialCategory: widget.initialCategory),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<FavoritesProvider>()..loadFavorites(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<StatsProvider>()..loadStats(),
        ),
      ],
      child: Stack(
        children: [
          Scaffold(
            key: const ValueKey('main_scaffold'),
            body: IndexedStack(
              index: _currentIndex,
              children: [
                // 0 — Módulos / Dashboard
                _selectedModule == null
                    ? ModuleSelectionScreen(
                        onModuleSelected: (module) =>
                            setState(() => _selectedModule = module),
                      )
                    : DashboardScreen(
                        module: _selectedModule!,
                        onGoToLearn: () => _goTo(1),
                        onGoToStories: () => _goTo(2),
                        onGoToFavorites: () => _goTo(3),
                        onBack: () => setState(() => _selectedModule = null),
                      ),
                // 1 — Learn
                const HomeScreen(),
                // 2 — Stories
                const StoriesPage(),
                // 3 — Favoritos
                const FavoritesScreen(),
                // 4 — Perfil
                const ProfileScreen(),
              ],
            ),
            bottomNavigationBar: Consumer<FavoritesProvider>(
              builder: (context, favProvider, _) {
                final navBg = AppTheme.navBarColor(context);
                final navBorder = AppTheme.navBarBorderColor(context);
                final primary = Theme.of(context).colorScheme.primary;
                final unselected = AppTheme.secondaryTextColor(context);

                return Container(
                  decoration: BoxDecoration(
                    color: navBg,
                    border: Border(
                      top: BorderSide(color: navBorder, width: 0.5),
                    ),
                  ),
                  child: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    onTap: _goTo,
                    backgroundColor: navBg,
                    selectedItemColor: primary,
                    unselectedItemColor: unselected,
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home_rounded),
                        label: 'Home',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.collections_bookmark_rounded),
                        label: 'Learn',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.auto_stories_rounded),
                        label: 'Stories',
                      ),
                      BottomNavigationBarItem(
                        icon: Stack(
                          children: [
                            const Icon(Icons.favorite_rounded),
                            if (favProvider.totalFavoritesCount > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: primary,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    '${favProvider.totalFavoritesCount}',
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(0xFF1C1C1E)
                                          : Colors.white,
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        label: 'Favoritos',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.person_rounded),
                        label: 'Perfil',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}
