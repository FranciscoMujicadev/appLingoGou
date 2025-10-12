// lib/presentation/screens/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/tts_service.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
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
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${favoritesProvider.totalFavoritesCount}',
                          style: const TextStyle(
                            color: Colors.red,
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
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelColor: Colors.white,
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
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Ve al inicio y marca frases como favoritas',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[800]!, width: 1),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phrase.english,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phrase.spanish,
                  style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                ),
                const SizedBox(height: 4),
                Text(
                  phrase.pronunciation,
                  style: GoogleFonts.robotoMono(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Categoría: ${phrase.category}',
                style: TextStyle(fontSize: 12, color: Colors.blue[300]),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _ttsService.speak(phrase.english),
                  icon: const Icon(Icons.volume_up, color: Colors.blue),
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
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Ve a los ejemplos de uso y marca los que más te gusten',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink.shade900.withOpacity(0.3),
                Colors.purple.shade900.withOpacity(0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.pink.withOpacity(0.5), width: 2),
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
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contextItem.phraseIdiom,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            contextItem.context,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.pink.shade200,
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
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"${contextItem.englishExample}"',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                      if (contextItem.pronunciation.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          '🗣️ ${contextItem.pronunciation}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange.shade300,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '🇲🇽 ${contextItem.spanishExample}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
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
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        contextItem.category,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue.shade300,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () =>
                          _ttsService.speak(contextItem.englishExample),
                      icon: const Icon(
                        Icons.volume_up,
                        color: Colors.blue,
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
