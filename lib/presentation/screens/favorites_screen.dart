// lib/presentation/screens/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/tts_service.dart';
import '../../providers/theme_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/stats_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  final TtsService _ttsService = TtsService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _ttsService.initialize();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _ttsService.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _removeFromFavorites(int index) async {
    final favoritesProvider = context.read<FavoritesProvider>();
    final statsProvider = context.read<StatsProvider>();

    final phrase = favoritesProvider.favorites[index];
    await favoritesProvider.toggleFavorite(phrase);
    await statsProvider.updateAchievements(favoritesProvider.favoritesCount);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Frase eliminada de favoritos'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _removeFavoriteContext(String contextId) async {
    final favoritesProvider = context.read<FavoritesProvider>();

    await favoritesProvider.toggleFavoriteContext(
      favoritesProvider.favoriteContexts.firstWhere((c) => c.id == contextId),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ejemplo eliminado de favoritos'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Consumer<FavoritesProvider>(
          builder: (context, favoritesProvider, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        'Favoritos',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 23.5,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, _) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: IconButton(
                              key: ValueKey(themeProvider.isDarkMode),
                              onPressed: themeProvider.toggleTheme,
                              icon: Icon(
                                themeProvider.isDarkMode
                                    ? Icons.wb_sunny_rounded
                                    : Icons.nightlight_round,
                                color: theme.colorScheme.primary,
                              ),
                              tooltip: themeProvider.isDarkMode
                                  ? 'Modo claro'
                                  : 'Modo oscuro',
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${favoritesProvider.totalFavoritesCount}',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: const Color.fromARGB(255, 54, 114, 244),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelColor: const Color.fromARGB(255, 255, 255, 255),
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.bookmark, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Frases (${favoritesProvider.favoritesCount})',
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.chat_bubble_outline, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Ejemplos (${favoritesProvider.favoriteContextsCount})',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildPhrasesTab(favoritesProvider),
                      _buildContextsTab(favoritesProvider),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPhrasesTab(FavoritesProvider favoritesProvider) {
    final favorites = favoritesProvider.favorites;

    if (favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_border, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No tienes frases favoritas',
              style: GoogleFonts.plusJakartaSans(fontSize: 17.5, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Ve al inicio y marca frases como favoritas',
              style: TextStyle(fontSize: 13.5, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final phrase = favorites[index];

        final theme = Theme.of(context);
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: theme.dividerColor, width: 1),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phrase.english,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 19.5,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phrase.spanish,
                  style: TextStyle(
                    fontSize: 15.5,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phrase.pronunciation,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.5,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Categoría: ${phrase.category}',
                style: const TextStyle(fontSize: 13.5, color: Color(0xFF9C95FF)),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _ttsService.speak(phrase.english),
                  icon: const Icon(Icons.volume_up, color: Color(0xFF6C63FF)),
                ),
                IconButton(
                  onPressed: () => _removeFromFavorites(index),
                  icon: const Icon(Icons.favorite, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContextsTab(FavoritesProvider favoritesProvider) {
    final favoriteContexts = favoritesProvider.favoriteContexts;

    if (favoriteContexts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No tienes ejemplos favoritos',
              style: GoogleFonts.plusJakartaSans(fontSize: 17.5, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Ve a los ejemplos de uso y marca los que más te gusten',
                style: TextStyle(fontSize: 13.5, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: favoriteContexts.length,
      itemBuilder: (context, index) {
        final contextItem = favoriteContexts[index];
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final onSurface = Theme.of(context).colorScheme.onSurface;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: isDark
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.pink.shade900.withValues(alpha: 0.3),
                      Colors.purple.shade900.withValues(alpha: 0.3),
                    ],
                  )
                : null,
            color: isDark ? null : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.pink.withValues(alpha: isDark ? 0.5 : 0.4),
              width: 2,
            ),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.pink.withValues(alpha: 0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      contextItem.emoji,
                      style: const TextStyle(fontSize: 27.5),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contextItem.phraseIdiom,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20.5,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : onSurface,
                            ),
                          ),
                          Text(
                            contextItem.context,
                            style: TextStyle(
                              fontSize: 13.5,
                              color: isDark
                                  ? Colors.pink.shade200
                                  : Colors.pink.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.3)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"${contextItem.englishExample}"',
                        style: TextStyle(
                          fontSize: 15.5,
                          color: isDark ? Colors.white : onSurface,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                      if (contextItem.pronunciation.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          '🗣️ ${contextItem.pronunciation}',
                          style: TextStyle(
                            fontSize: 14.5,
                            color: isDark
                                ? Colors.orange.shade300
                                : Colors.orange.shade700,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '🇲🇽 ${contextItem.spanishExample}',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: isDark
                                ? Colors.white
                                : Colors.green.shade800,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        contextItem.category,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: isDark
                              ? const Color(0xFF9C95FF)
                              : const Color(0xFF5248CC),
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () =>
                          _ttsService.speak(contextItem.englishExample),
                      icon: const Icon(
                        Icons.volume_up,
                        color: Color(0xFF6C63FF),
                        size: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _removeFavoriteContext(contextItem.id),
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
