import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/stats_provider.dart';
import '../providers/favorites_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Consumer2<StatsProvider, FavoritesProvider>(
          builder: (context, statsProvider, favProvider, _) {
            // Actualizar logros cuando cambie el estado
            WidgetsBinding.instance.addPostFrameCallback((_) {
              statsProvider.updateAchievements(favProvider.favoritesCount);
            });

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estadísticas',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildStatCard(
                    'Frases favoritas',
                    '${favProvider.favoritesCount}',
                    Icons.favorite,
                    Colors.red,
                    showProgress: true,
                    progress: favProvider.favoritesCount / 50.0,
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(
                    'Frases estudiadas',
                    '${statsProvider.phrasesViewed}',
                    Icons.school,
                    Colors.green,
                    showProgress: true,
                    progress: statsProvider.phrasesViewed / 100.0,
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(
                    'Categorías exploradas',
                    '${statsProvider.categoriesExplored}/4',
                    Icons.explore,
                    Colors.purple,
                    showProgress: true,
                    progress: statsProvider.categoriesExplored / 4.0,
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(
                    'Veces compartido',
                    '${statsProvider.shareAttempts}',
                    Icons.share,
                    Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(
                    'Tiempo de estudio',
                    '${(statsProvider.phrasesViewed * 0.5).toStringAsFixed(1)} min',
                    Icons.timer,
                    Colors.blue,
                    subtitle: 'Promedio: 30 seg por frase',
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        'Logros',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${statsProvider.getUnlockedAchievementsCount()}/6',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildAchievement(
                    'Primer paso',
                    'Abre la app por primera vez',
                    statsProvider.hasFirstStep,
                    icon: Icons.play_arrow,
                  ),
                  _buildAchievement(
                    'Coleccionista',
                    'Guarda 5 frases favoritas',
                    statsProvider.isCollector,
                    icon: Icons.bookmark,
                    progress: favProvider.favoritesCount / 5.0,
                  ),
                  _buildAchievement(
                    'Estudioso',
                    'Estudia 20 frases',
                    statsProvider.isStudious,
                    icon: Icons.school,
                    progress: statsProvider.phrasesViewed / 20.0,
                  ),
                  _buildAchievement(
                    'Explorador',
                    'Descubre todas las categorías',
                    statsProvider.isExplorer,
                    icon: Icons.explore,
                    progress: statsProvider.categoriesExplored / 4.0,
                  ),
                  _buildAchievement(
                    'Compartir es vivir',
                    'Comparte 3 frases',
                    statsProvider.isSharer,
                    icon: Icons.share,
                    progress: statsProvider.shareAttempts / 3.0,
                  ),
                  _buildAchievement(
                    'Maestro del inglés',
                    'Estudia 50 frases',
                    statsProvider.isMaster,
                    icon: Icons.military_tech,
                    progress: statsProvider.phrasesViewed / 50.0,
                  ),
                  const SizedBox(height: 30),
                  _buildOverallProgress(statsProvider),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color, {
    String? subtitle,
    bool showProgress = false,
    double progress = 0.0,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
                if (showProgress) ...[
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    backgroundColor: Colors.grey[800],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 4,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievement(
    String title,
    String description,
    bool isUnlocked, {
    IconData? icon,
    double progress = 0.0,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked ? Colors.amber : Colors.grey[800]!,
          width: isUnlocked ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? Colors.amber.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon ?? (isUnlocked ? Icons.check_circle : Icons.lock),
                  color: isUnlocked ? Colors.amber : Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isUnlocked ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: isUnlocked ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (isUnlocked)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.star, color: Colors.black, size: 16),
                ),
            ],
          ),
          if (!isUnlocked && progress > 0) ...[
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              minHeight: 6,
            ),
            const SizedBox(height: 4),
            Text(
              '${(progress * 100).toInt()}% completado',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverallProgress(StatsProvider statsProvider) {
    final totalPossible = 100;
    final currentProgress = statsProvider.phrasesViewed;
    final percentage = (currentProgress / totalPossible).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.withOpacity(0.3),
            Colors.blue.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.purple.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.trending_up, color: Colors.purple, size: 24),
              const SizedBox(width: 12),
              Text(
                'Progreso General',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[800],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$currentProgress de $totalPossible frases',
                style: TextStyle(color: Colors.grey[300], fontSize: 14),
              ),
              Text(
                '${(percentage * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.purple,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
