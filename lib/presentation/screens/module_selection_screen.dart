// lib/presentation/screens/module_selection_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/config/modules_config.dart';
import '../../core/models/module_model.dart';
import '../providers/phrases_provider.dart';
import '../providers/stats_provider.dart';

class ModuleSelectionScreen extends StatelessWidget {
  final ValueChanged<AppModule> onModuleSelected;

  const ModuleSelectionScreen({super.key, required this.onModuleSelected});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0A0A15) : const Color(0xFFF2F2F7);
    final textColor = isDark ? Colors.white : const Color(0xFF1C1C1E);
    final subtitleColor = isDark ? const Color(0xFF8E8E93) : const Color(0xFF6C6C70);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Consumer2<PhrasesProvider, StatsProvider>(
          builder: (context, phrasesProvider, statsProvider, _) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Elige tu módulo',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 27.5,
                            fontWeight: FontWeight.w800,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '¿Qué inglés quieres aprender hoy?',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.5,
                            color: subtitleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) {
                        final module = kAppModules[i];
                        return _ModuleCard(
                          module: module,
                          phrasesProvider: phrasesProvider,
                          statsProvider: statsProvider,
                          onTap: () => onModuleSelected(module),
                          isDark: isDark,
                        );
                      },
                      childCount: kAppModules.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final AppModule module;
  final PhrasesProvider phrasesProvider;
  final StatsProvider statsProvider;
  final VoidCallback onTap;
  final bool isDark;

  const _ModuleCard({
    required this.module,
    required this.phrasesProvider,
    required this.statsProvider,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final totalLevels = module.endLevel - module.startLevel + 1;
    final completedLevels = statsProvider.exploredCategories
        .where((cat) {
          final match = RegExp(r'\d+').firstMatch(cat);
          if (match == null) return false;
          final n = int.tryParse(match.group(0)!) ?? 0;
          return module.containsLevel(n);
        })
        .length;

    final progress = totalLevels > 0 ? completedLevels / totalLevels : 0.0;
    final cardBg = isDark ? const Color(0xFF16213E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1C1C1E);
    final subtitleColor = isDark ? const Color(0xFF8E8E93) : const Color(0xFF6C6C70);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: module.color.withValues(alpha:0.15),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header con color del módulo
              Container(
                decoration: BoxDecoration(
                  color: module.color,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha:0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(module.icon, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            module.name,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '$totalLevels niveles',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              color: Colors.white.withValues(alpha:0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha:0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              // Body con descripción y progreso
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.description,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        color: subtitleColor,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: isDark
                                  ? Colors.white.withValues(alpha:0.08)
                                  : Colors.black.withValues(alpha:0.06),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(module.color),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '$completedLevels / $totalLevels',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
