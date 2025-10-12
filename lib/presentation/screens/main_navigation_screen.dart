// lib/presentation/screens/main_navigation_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/injection_container.dart' as di;
import '../providers/phrases_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/stats_provider.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'stats_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<PhrasesProvider>()..initialize(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<FavoritesProvider>()..loadFavorites(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<StatsProvider>()..loadStats(),
        ),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [HomeScreen(), FavoritesScreen(), StatsScreen()],
        ),
        bottomNavigationBar: Consumer2<FavoritesProvider, StatsProvider>(
          builder: (context, favProvider, statsProvider, _) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
                backgroundColor: Colors.black,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Inicio',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        const Icon(Icons.favorite),
                        if (favProvider.totalFavoritesCount > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${favProvider.totalFavoritesCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
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
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        const Icon(Icons.analytics),
                        if (_hasNewAchievements(statsProvider))
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                    label: 'Estadísticas',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool _hasNewAchievements(StatsProvider statsProvider) {
    return (statsProvider.isCollector && statsProvider.phrasesViewed == 20) ||
        (statsProvider.isStudious && statsProvider.phrasesViewed == 20) ||
        (statsProvider.isExplorer && statsProvider.categoriesExplored == 4);
  }
}
