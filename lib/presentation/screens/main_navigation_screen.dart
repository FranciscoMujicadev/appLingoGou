// lib/presentation/screens/main_navigation_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/injection_container.dart' as di;
import '../../theme/app_theme.dart';
import '../providers/phrases_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/stats_provider.dart';
import '../../providers/ad_provider.dart';
import 'dashboard_screen.dart';
import 'home_screen.dart';
import 'stories_page.dart';
import 'favorites_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _goTo(int index) => setState(() => _currentIndex = index);

  @override
  void initState() {
    super.initState();
  }

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
        ChangeNotifierProvider(create: (_) => AdProvider()),
      ],
      child: Stack(
        children: [
          Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: [
                // 0 — Dashboard
                DashboardScreen(
                  onGoToLearn: () => _goTo(1),
                  onGoToStories: () => _goTo(2),
                  onGoToFavorites: () => _goTo(3),
                ),
                // 1 — Learn
                const HomeScreen(),
                // 2 — Stories
                const StoriesPage(),
                // 3 — Favoritos
                const FavoritesScreen(),
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
