// lib/presentation/screens/dashboard_screen.dart

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/phrases_provider.dart';
import '../providers/stats_provider.dart';
import '../../core/utils/onboarding_storage.dart';
import '../../providers/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback onGoToLearn;
  final VoidCallback onGoToStories;
  final VoidCallback onGoToFavorites;

  const DashboardScreen({
    super.key,
    required this.onGoToLearn,
    required this.onGoToStories,
    required this.onGoToFavorites,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  static const List<String> _sectionTitles = [
    'Saludos y presentaciones',
    'Vocabulario básico',
    'Gramática esencial',
    'Conversación cotidiana',
    'Expresiones comunes',
    'Vocabulario avanzado',
    'Situaciones reales',
    'Fluidez y naturalidad',
    'Comprensión avanzada',
    'Dominio del inglés',
  ];

  static const List<Color> _sectionColors = [
    Color(0xFF58CC02),
    Color(0xFF6C63FF),
    Color(0xFF1CB0F6),
    Color(0xFFFF9600),
    Color(0xFFFF4B4B),
    Color(0xFF2AC3A2),
    Color(0xFFCE82FF),
    Color(0xFFFFC107),
    Color(0xFF9B59B6),
    Color(0xFF3498DB),
  ];

  // Alignment.x values for each position in a section (-1 = left, 0 = center, 1 = right)
  static const List<double> _nodeAlignX = [
    0.0, 0.55, 0.8, 0.55, 0.0, -0.55, -0.8, -0.55, 0.0, 0.55,
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0A0A15) : const Color(0xFFF2F2F7);
    final textColor = isDark ? Colors.white : const Color(0xFF1C1C1E);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Consumer2<PhrasesProvider, StatsProvider>(
          builder: (context, phrasesProvider, statsProvider, _) {
            if (statsProvider.pendingGoalCelebration) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                statsProvider.clearPendingGoalCelebration();
                OnboardingStorage.markGoalCelebratedToday();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const _GoalCelebrationDialog(),
                );
              });
            }

            final cats = phrasesProvider.categories;
            final current = phrasesProvider.selectedCategory;
            final explored = statsProvider.exploredCategories;

            final items = <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: _Header(isDark: isDark, textColor: textColor),
              ),
            ];

            for (int s = 0; s < 10; s++) {
              final start = s * 10;
              if (start >= cats.length) break;
              final end = math.min(start + 10, cats.length);

              items.add(_SectionBanner(
                number: s + 1,
                title: _sectionTitles[s],
                color: _sectionColors[s],
              ));
              items.add(const SizedBox(height: 24));

              for (int i = 0; i < end - start; i++) {
                final idx = start + i;
                final name = cats[idx].name;
                final isActive = name == current;
                final isCompleted = explored.contains(name) && !isActive;
                final numPhrases = phrasesProvider.currentPhrases.length;
                // Each phrase generates 5 pages + 1 final page (same as home_screen totalPages)
                final totalPages = numPhrases > 0 ? numPhrases * 5 + 1 : 0;
                final maxReached = phrasesProvider.getProgressForCategory(name);
                final progress = isActive && totalPages > 0
                    ? (maxReached / totalPages).clamp(0.0, 1.0)
                    : 0.0;
                items.add(_LevelNodeRow(
                  levelNumber: idx + 1,
                  isActive: isActive,
                  isCompleted: isCompleted,
                  sectionColor: _sectionColors[s],
                  alignX: _nodeAlignX[i % _nodeAlignX.length],
                  isDark: isDark,
                  progress: progress,
                  onTap: () {
                    phrasesProvider.changeCategory(name);
                    widget.onGoToLearn();
                  },
                ));
              }

              items.add(const SizedBox(height: 12));
            }

            items.add(const SizedBox(height: 40));
            return ListView(children: items);
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
// Section Banner
// ─────────────────────────────────────────────

class _SectionBanner extends StatelessWidget {
  final int number;
  final String title;
  final Color color;

  const _SectionBanner({
    required this.number,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      color: color,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SECCIÓN $number',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.8),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'GUÍA',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Level Node Row
// ─────────────────────────────────────────────

class _LevelNodeRow extends StatelessWidget {
  final int levelNumber;
  final bool isActive;
  final bool isCompleted;
  final Color sectionColor;
  final double alignX;
  final bool isDark;
  final double progress;
  final VoidCallback onTap;

  const _LevelNodeRow({
    required this.levelNumber,
    required this.isActive,
    required this.isCompleted,
    required this.sectionColor,
    required this.alignX,
    required this.isDark,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelColor = isActive
        ? sectionColor
        : isCompleted
            ? sectionColor
            : (isDark ? const Color(0xFF5A5A7A) : const Color(0xFFAAAAAA));

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Align(
          alignment: Alignment(alignX, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isActive) ...[
                _StartBubble(color: sectionColor, progress: progress),
                const SizedBox(height: 6),
              ],
              _NodeCircle(
                isActive: isActive,
                isCompleted: isCompleted,
                sectionColor: sectionColor,
                isDark: isDark,
              ),
              const SizedBox(height: 6),
              Text(
                'Nivel $levelNumber',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: labelColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Start Bubble
// ─────────────────────────────────────────────

class _StartBubble extends StatelessWidget {
  final Color color;
  final double progress;
  const _StartBubble({required this.color, this.progress = 0.0});

  @override
  Widget build(BuildContext context) {
    final pct = (progress * 100).round();
    final label = pct > 0 ? '$pct% completado' : 'EMPEZAR';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
        ),
        CustomPaint(
          size: const Size(16, 8),
          painter: _TrianglePainter(color: Colors.white),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────
// Node Circle
// ─────────────────────────────────────────────

class _NodeCircle extends StatelessWidget {
  final bool isActive;
  final bool isCompleted;
  final Color sectionColor;
  final bool isDark;

  const _NodeCircle({
    required this.isActive,
    required this.isCompleted,
    required this.sectionColor,
    required this.isDark,
  });

  Color _darken(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.18).clamp(0.0, 1.0)).toColor();
  }

  @override
  Widget build(BuildContext context) {
    final double size = isActive ? 76 : 68;

    if (isActive) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: sectionColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _darken(sectionColor),
              blurRadius: 0,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: sectionColor.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text('⭐', style: TextStyle(fontSize: 28)),
        ),
      );
    }

    if (isCompleted) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: sectionColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _darken(sectionColor),
              blurRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.star_rounded, color: Colors.white, size: 26),
        ),
      );
    }

    // Upcoming / locked
    final lockBg = isDark ? const Color(0xFF1C1C2E) : Colors.white;
    final lockBorder = isDark ? const Color(0xFF2D2D4E) : const Color(0xFFDDDDE5);
    final lockShadow = isDark ? const Color(0xFF0A0A15) : const Color(0xFFBBBBC4);
    final lockIcon = isDark ? const Color(0xFF3A3A5C) : const Color(0xFFBBBBC4);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: lockBg,
        shape: BoxShape.circle,
        border: Border.all(color: lockBorder, width: 3),
        boxShadow: [
          BoxShadow(
            color: lockShadow,
            blurRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Icon(Icons.star_rounded, color: lockIcon, size: 26),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Goal Celebration Dialog
// ─────────────────────────────────────────────

class _GoalCelebrationDialog extends StatelessWidget {
  const _GoalCelebrationDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 32, 28, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎉', style: TextStyle(fontSize: 56)),
            const SizedBox(height: 16),
            Text(
              '¡Meta diaria cumplida!',
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Completaste tu práctica de hoy.\n¡Sigue así y tu inglés mejorará cada día!',
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15,
                color: const Color(0xFF666666),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF58CC02),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF58CC02).withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '¡GENIAL!',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
