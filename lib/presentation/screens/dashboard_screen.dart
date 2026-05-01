// lib/presentation/screens/dashboard_screen.dart

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/phrases_provider.dart';
import '../providers/stats_provider.dart';
import '../../core/models/module_model.dart';
import '../../domain/entities/category_entity.dart';
import '../../core/utils/onboarding_storage.dart';
import '../../providers/theme_provider.dart';
import '../widgets/breadcrumb_bar.dart';

class DashboardScreen extends StatefulWidget {
  final AppModule module;
  final VoidCallback onGoToLearn;
  final VoidCallback onGoToStories;
  final VoidCallback onGoToFavorites;
  final VoidCallback onBack;

  const DashboardScreen({
    super.key,
    required this.module,
    required this.onGoToLearn,
    required this.onGoToStories,
    required this.onGoToFavorites,
    required this.onBack,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _scrollController = ScrollController();

  // Alignment.x values for the zigzag path
  static const List<double> _nodeAlignX = [
    0.0, 0.55, 0.8, 0.55, 0.0, -0.55, -0.8, -0.55, 0.0, 0.55,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<PhrasesProvider>();
      _scrollToActive(_filteredCats(provider.categories));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<CategoryEntity> _filteredCats(List<CategoryEntity> cats) {
    return cats.where((c) {
      final match = RegExp(r'\d+').firstMatch(c.name);
      if (match == null) return false;
      return widget.module.containsLevel(int.parse(match.group(0)!));
    }).toList();
  }

  void _scrollToActive(List<CategoryEntity> filteredCats) {
    if (!mounted || !_scrollController.hasClients) return;
    final provider = context.read<PhrasesProvider>();
    final activeIdx =
        filteredCats.indexWhere((c) => c.name == provider.selectedCategory);
    if (activeIdx <= 0) return;

    const headerH = 80.0;
    const bannerH = 52.0;
    const bannerGap = 24.0;
    const nodeH = 95.0;
    const sectionEndGap = 12.0;
    const nodesPerSection = 10;

    final sectionIndex = activeIdx ~/ nodesPerSection;
    final nodeInSection = activeIdx % nodesPerSection;

    double offset = headerH;
    offset +=
        sectionIndex * (bannerH + bannerGap + nodesPerSection * nodeH + sectionEndGap);
    offset += bannerH + bannerGap;
    offset += nodeInSection * nodeH;
    offset = (offset - 60)
        .clamp(0.0, _scrollController.position.maxScrollExtent);

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

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
              final goalTime = statsProvider.pendingGoalTime;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                statsProvider.clearPendingGoalCelebration();
                OnboardingStorage.markGoalCelebratedToday();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => _GoalCelebrationDialog(time: goalTime),
                );
              });
            }

            final filteredCats = _filteredCats(phrasesProvider.categories);
            final current = phrasesProvider.selectedCategory;
            final explored = statsProvider.exploredCategories;
            final numPhrases = phrasesProvider.currentPhrases.length;
            final totalPages = numPhrases > 0 ? numPhrases * 5 + 1 : 0;
            final sections = widget.module.sections;

            final specs = <_DashSpec>[];
            specs.add(const _HeaderSpec());

            for (int s = 0; s < sections.length; s++) {
              final start = s * 10;
              if (start >= filteredCats.length) break;
              final end = math.min(start + 10, filteredCats.length);
              specs.add(_BannerSpec(s));
              specs.add(const _GapSpec(24));
              for (int i = 0; i < end - start; i++) {
                final idx = start + i;
                final name = filteredCats[idx].name;
                final isActive = name == current;
                final isCompleted = explored.contains(name) && !isActive;
                final maxReached =
                    phrasesProvider.getProgressForCategory(name);
                final progress = isActive && totalPages > 0
                    ? (maxReached / totalPages).clamp(0.0, 1.0)
                    : 0.0;
                specs.add(_NodeSpec(
                  levelNumber: idx + 1,
                  isActive: isActive,
                  isCompleted: isCompleted,
                  sectionIdx: s,
                  nodeInSection: i,
                  progress: progress,
                  categoryName: name,
                ));
              }
              specs.add(const _GapSpec(12));
            }
            specs.add(const _GapSpec(40));

            return ListView.builder(
              controller: _scrollController,
              itemCount: specs.length,
              itemBuilder: (ctx, i) {
                final spec = specs[i];
                if (spec is _HeaderSpec) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                        child: _Header(
                          isDark: isDark,
                          textColor: textColor,
                          module: widget.module,
                          onBack: widget.onBack,
                        ),
                      ),
                      BreadcrumbBar(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                        segments: [
                          BreadcrumbSegment(
                            label: 'Módulos',
                            icon: Icons.apps_rounded,
                            onTap: widget.onBack,
                          ),
                          BreadcrumbSegment(label: widget.module.name),
                        ],
                      ),
                    ],
                  );
                }
                if (spec is _GapSpec) return SizedBox(height: spec.height);
                if (spec is _BannerSpec) {
                  final section = sections[spec.section];
                  return _SectionBanner(
                    number: spec.section + 1,
                    title: section.title,
                    color: section.color,
                  );
                }
                if (spec is _NodeSpec) {
                  final sectionColor = sections[spec.sectionIdx].color;
                  return _LevelNodeRow(
                    levelNumber: spec.levelNumber,
                    isActive: spec.isActive,
                    isCompleted: spec.isCompleted,
                    sectionColor: sectionColor,
                    alignX: _nodeAlignX[spec.nodeInSection % _nodeAlignX.length],
                    isDark: isDark,
                    progress: spec.progress,
                    onTap: () {
                      phrasesProvider.changeCategory(spec.categoryName);
                      widget.onGoToLearn();
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Spec classes (lightweight data, no Widgets)
// ─────────────────────────────────────────────

sealed class _DashSpec {
  const _DashSpec();
}

class _HeaderSpec extends _DashSpec {
  const _HeaderSpec();
}

class _GapSpec extends _DashSpec {
  final double height;
  const _GapSpec(this.height);
}

class _BannerSpec extends _DashSpec {
  final int section;
  const _BannerSpec(this.section);
}

class _NodeSpec extends _DashSpec {
  final int levelNumber;
  final bool isActive;
  final bool isCompleted;
  final int sectionIdx;
  final int nodeInSection;
  final double progress;
  final String categoryName;
  const _NodeSpec({
    required this.levelNumber,
    required this.isActive,
    required this.isCompleted,
    required this.sectionIdx,
    required this.nodeInSection,
    required this.progress,
    required this.categoryName,
  });
}

// ─────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────

class _Header extends StatelessWidget {
  final bool isDark;
  final Color textColor;
  final AppModule module;
  final VoidCallback onBack;

  const _Header({
    required this.isDark,
    required this.textColor,
    required this.module,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
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
              Icons.arrow_back_rounded,
              color: textColor,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                module.name,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
              Text(
                '${module.endLevel - module.startLevel + 1} niveles',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5,
                  color: isDark
                      ? const Color(0xFF8E8E93)
                      : const Color(0xFF6C6C70),
                ),
              ),
            ],
          ),
        ),
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
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
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.5,
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
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5,
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
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
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
          child: Text('⭐', style: TextStyle(fontSize: 27.5)),
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
  final String? time;
  const _GoalCelebrationDialog({this.time});

  @override
  Widget build(BuildContext context) {
    final timeLabel = time != null ? time! : 'tu meta';
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 32, 28, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🏆', style: TextStyle(fontSize: 63.5)),
            const SizedBox(height: 16),
            Text(
              '¡Lo lograste!',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 23.5,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFDDF4C1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                timeLabel,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF3A8C00),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              '¡Completaste tu práctica de hoy!\nSigue explorando si quieres más.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
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
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15.5,
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
