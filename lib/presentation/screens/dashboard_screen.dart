// lib/presentation/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/phrases_provider.dart';
import '../providers/stats_provider.dart';
import '../../providers/theme_provider.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onGoToLearn;
  final VoidCallback onGoToStories;
  final VoidCallback onGoToFavorites;

  const DashboardScreen({
    super.key,
    required this.onGoToLearn,
    required this.onGoToStories,
    required this.onGoToFavorites,
  });

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Buenos días';
    if (hour < 18) return 'Buenas tardes';
    return 'Buenas noches';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0A0A15) : const Color(0xFFF2F2F7);
    final surface = isDark ? const Color(0xFF1C1C2E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1C1C1E);
    final subColor =
        isDark ? Colors.white54 : const Color(0xFF6C6C70);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Consumer2<PhrasesProvider, StatsProvider>(
          builder: (context, phrasesProvider, statsProvider, _) {
            final phrases = phrasesProvider.currentPhrases;
            final totalPages =
                phrases.isEmpty ? 1 : (phrases.length * 5) + 1;
            final currentIndex = phrasesProvider.currentIndex;
            final progress =
                totalPages <= 1 ? 0.0 : currentIndex / (totalPages - 1);
            final dayLabel = phrasesProvider.selectedCategory;
            final dayNumber = phrasesProvider.currentDayNumber;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ── Header ──
                  _Header(isDark: isDark, textColor: textColor),
                  const SizedBox(height: 24),

                  // ── Greeting ──
                  Text(
                    '${_greeting()} 👋',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$dayLabel de ${phrasesProvider.totalDays}',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: subColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── CTA Card ──
                  _CtaCard(
                    dayLabel: dayLabel,
                    dayNumber: dayNumber,
                    phraseCount: phrases.length,
                    cardIndex: currentIndex,
                    totalCards: totalPages,
                    progress: progress,
                    onTap: onGoToLearn,
                  ),
                  const SizedBox(height: 28),

                  // ── Stats ──
                  Text(
                    'Tu progreso',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: 'Frases',
                          value: '${statsProvider.phrasesViewed}',
                          icon: '📚',
                          color: const Color(0xFF6C63FF),
                          surface: surface,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          label: 'Logros',
                          value:
                              '${statsProvider.getUnlockedAchievementsCount()}/6',
                          icon: '🏆',
                          color: const Color(0xFFFFC107),
                          surface: surface,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          label: 'Niveles',
                          value: '${statsProvider.categoriesExplored}',
                          icon: '📅',
                          color: const Color(0xFF58CC02),
                          surface: surface,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // ── Explore ──
                  Text(
                    'Explorar',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _ExploreCard(
                          label: 'Stories',
                          emoji: '📖',
                          subtitle: 'Lee y escucha historias',
                          gradient: const [
                            Color(0xFF1CB0F6),
                            Color(0xFF0070CC),
                          ],
                          onTap: onGoToStories,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _ExploreCard(
                          label: 'Favoritos',
                          emoji: '❤️',
                          subtitle: 'Tus frases guardadas',
                          gradient: const [
                            Color(0xFFFF6B9D),
                            Color(0xFFCC4477),
                          ],
                          onTap: onGoToFavorites,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────

class _Header extends StatelessWidget {
  final bool isDark;
  final Color textColor;
  const _Header({required this.isDark, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'LingoGou',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
        const Spacer(),
        Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return GestureDetector(
              onTap: themeProvider.toggleTheme,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2D2D4E)
                      : const Color(0xFFE5E5EA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  themeProvider.isDarkMode
                      ? Icons.wb_sunny_rounded
                      : Icons.nightlight_round,
                  color: themeProvider.isDarkMode
                      ? const Color(0xFFFFC107)
                      : const Color(0xFF6C63FF),
                  size: 20,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// CTA Card
// ─────────────────────────────────────────────

class _CtaCard extends StatelessWidget {
  final String dayLabel;
  final int dayNumber;
  final int phraseCount;
  final int cardIndex;
  final int totalCards;
  final double progress;
  final VoidCallback onTap;

  const _CtaCard({
    required this.dayLabel,
    required this.dayNumber,
    required this.phraseCount,
    required this.cardIndex,
    required this.totalCards,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final percent = (clampedProgress * 100).round();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6C63FF), Color(0xFF4834DF)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tag + fire
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '🔥 Continuar lección',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Day title
            Text(
              dayLabel,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$phraseCount frases · $totalCards actividades',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 18),

            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: clampedProgress,
                backgroundColor: Colors.white.withValues(alpha: 0.25),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Card $cardIndex de $totalCards',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '$percent%',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CONTINUAR',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF6C63FF),
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Color(0xFF6C63FF),
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Stat Card
// ─────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final Color color;
  final Color surface;
  final bool isDark;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.surface,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Explore Card
// ─────────────────────────────────────────────

class _ExploreCard extends StatelessWidget {
  final String label;
  final String emoji;
  final String subtitle;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _ExploreCard({
    required this.label,
    required this.emoji,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 10),
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
