// lib/presentation/screens/stats_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/stats_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Consumer<StatsProvider>(
          builder: (context, statsProvider, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título de estadísticas
                  Text(
                    '📊 Mis Estadísticas',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tu progreso de aprendizaje',
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Tarjetas de estadísticas
                  _buildStatCard(
                    context,
                    'Frases Estudiadas',
                    '${statsProvider.phrasesViewed}',
                    Icons.book,
                    Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildStatCard(
                    context,
                    'Veces Compartido',
                    '${statsProvider.shareAttempts}',
                    Icons.share,
                    Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildStatCard(
                    context,
                    'Categorías Exploradas',
                    '${statsProvider.categoriesExplored}',
                    Icons.explore,
                    Colors.orange,
                  ),
                  const SizedBox(height: 30),

                  // Sección de logros
                  Text(
                    '🏆 Logros',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildAchievement(
                    context,
                    'Primer Paso',
                    'Estudia tu primera frase',
                    statsProvider.hasFirstStep,
                    icon: Icons.stars,
                    progress: statsProvider.phrasesViewed > 0 ? 1.0 : 0.0,
                  ),
                  _buildAchievement(
                    context,
                    'Coleccionista',
                    'Guarda 5 frases favoritas',
                    statsProvider.isCollector,
                    icon: Icons.bookmark,
                    progress: 0.0,
                  ),
                  _buildAchievement(
                    context,
                    'Estudioso',
                    'Estudia 20 frases',
                    statsProvider.isStudious,
                    icon: Icons.school,
                    progress: statsProvider.phrasesViewed / 20.0,
                  ),
                  _buildAchievement(
                    context,
                    'Explorador',
                    'Descubre todas las categorías',
                    statsProvider.isExplorer,
                    icon: Icons.explore,
                    progress: statsProvider.categoriesExplored / 4.0,
                  ),
                  _buildAchievement(
                    context,
                    'Compartir es vivir',
                    'Comparte 3 frases',
                    statsProvider.isSharer,
                    icon: Icons.share,
                    progress: statsProvider.shareAttempts / 3.0,
                  ),
                  _buildAchievement(
                    context,
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
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievement(
    BuildContext context,
    String title,
    String description,
    bool isUnlocked, {
    required IconData icon,
    required double progress,
  }) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked
              ? Colors.amber.withValues(alpha: 0.5)
              : Colors.grey.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? Colors.amber.withValues(alpha: 0.2)
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isUnlocked ? Colors.amber : Colors.grey,
                  size: 24,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              if (isUnlocked)
                const Icon(Icons.check_circle, color: Colors.amber, size: 28),
            ],
          ),
          if (!isUnlocked && clampedProgress > 0) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: clampedProgress,
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${(clampedProgress * 100).toInt()}% completado',
              style: TextStyle(
                fontSize: 12,
                color: onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverallProgress(StatsProvider statsProvider) {
    final totalAchievements = 6;
    final unlockedAchievements = statsProvider.getUnlockedAchievementsCount();
    final progress = unlockedAchievements / totalAchievements;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF4834DF)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            '🎯 Progreso General',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 12,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$unlockedAchievements de $totalAchievements logros desbloqueados',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}
