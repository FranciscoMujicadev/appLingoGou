// lib/presentation/widgets/business_term_card.dart
// Card de introducción para términos de Business English.
// Reemplaza a PhraseCard en el módulo business_interviews.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/phrase_entity.dart';
import 'animated_volume_button.dart';

class BusinessTermCard extends StatelessWidget {
  final PhraseEntity phrase;
  final bool isFavorite;
  final VoidCallback onSpeak;
  final VoidCallback onToggleFavorite;
  final VoidCallback onShare;
  final VoidCallback onContinue;

  const BusinessTermCard({
    super.key,
    required this.phrase,
    required this.isFavorite,
    required this.onSpeak,
    required this.onToggleFavorite,
    required this.onShare,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ── Paleta ejecutiva ───────────────────────────────────────────────────
    const navy = Color(0xFF0D1B2A);
    // ignore: unused_local_variable
    const navyLight = Color(0xFF1B2A3B);
    const gold = Color(0xFFD4A843);
    const goldLight = Color(0xFFF0C060);
    final cardBg = isDark ? navy : Colors.white;
    final cardBorder =
        isDark ? Colors.white.withValues(alpha: 0.06) : const Color(0xFFE0E0E6);
    final termColor = isDark ? Colors.white : const Color(0xFF0D1B2A);
    final subtleText = isDark ? const Color(0xFF8E9BB0) : const Color(0xFF6C7A8D);
    final definitionBg = isDark
        ? Colors.white.withValues(alpha: 0.03)
        : const Color(0xFFF4F6FA);
    final definitionBorder = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : const Color(0xFFE2E6EF);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.45)
                : Colors.black.withValues(alpha: 0.07),
            blurRadius: 28,
            offset: const Offset(0, 10),
            spreadRadius: isDark ? -4 : -2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Column(
          children: [
            // ── Header degradado azul marino ─────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [const Color(0xFF0D1B2A), const Color(0xFF112233)]
                      : [const Color(0xFF0D47A1), const Color(0xFF1565C0)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge módulo + acciones
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: gold.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: gold.withValues(alpha: 0.35), width: 1),
                        ),
                        child: Text(
                          phrase.literalTranslation,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: goldLight,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      const Spacer(),
                      _ActionBtn(
                        icon: isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isFavorite ? Colors.red.shade400 : Colors.white54,
                        onTap: onToggleFavorite,
                      ),
                      const SizedBox(width: 8),
                      _ActionBtn(
                        icon: Icons.ios_share_rounded,
                        color: Colors.white54,
                        onTap: onShare,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Término principal
                  Text(
                    phrase.idiom,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 33.5,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                      letterSpacing: -0.8,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Pronunciación
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          width: 3,
                          height: 14,
                          decoration: BoxDecoration(
                            color: gold,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          phrase.pronunciation,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.55),
                            letterSpacing: 0.4,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      AnimatedVolumeButton(
                        onTap: onSpeak,
                        color: gold,
                      ),
                    ],
                  ),

                ],
              ),
            ),

            // ── Cuerpo ────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Definición ejecutiva
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: definitionBg,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: definitionBorder, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D47A1)
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: const Icon(
                                  Icons.lightbulb_outline_rounded,
                                  size: 16,
                                  color: Color(0xFF1565C0),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Qué significa en contexto ejecutivo',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: subtleText,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            phrase.realMeaning,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w600,
                              color: termColor,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Preview de escenarios
                    Text(
                      'Cómo se usa en 2 situaciones reales:',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: subtleText,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: phrase.contextExamples.take(2).map((ex) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.04)
                                : const Color(0xFFF0F4FF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : const Color(0xFFDDE3F5),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(ex.emoji, style: const TextStyle(fontSize: 13.5)),
                              const SizedBox(width: 6),
                              Text(
                                ex.context,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.7)
                                      : const Color(0xFF2D4A8A),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // Botón continuar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D47A1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ver escenarios reales',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn(
      {required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
