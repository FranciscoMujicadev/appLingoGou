import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/phrase_entity.dart';
import 'animated_volume_button.dart';

class PhraseCard extends StatelessWidget {
  final PhraseEntity phrase;
  final String? gifUrl;
  final bool isFavorite;
  final VoidCallback onSpeak;
  final VoidCallback onToggleFavorite;
  final VoidCallback onShare;

  const PhraseCard({
    super.key,
    required this.phrase,
    this.gifUrl,
    required this.isFavorite,
    required this.onSpeak,
    required this.onToggleFavorite,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ── Colores adaptativos ──────────────────────────────────────────────
    final titleColor = isDark ? Colors.white : const Color(0xFF1C1C1E);
    final pronunciationColor = isDark
        ? Colors.white.withValues(alpha: 0.5)
        : const Color(0xFF6C6C70);
    final innerCardBg =
        isDark ? Colors.white.withValues(alpha: 0.02) : const Color(0xFFF2F2F7);
    final innerCardBorder = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : const Color(0xFFE5E5EA);
    final labelColor = isDark
        ? Colors.white.withValues(alpha: 0.4)
        : const Color(0xFF8E8E93);
    final literalTextColor = isDark
        ? Colors.white.withValues(alpha: 0.7)
        : const Color(0xFF3A3A3C);
    final meaningTextColor = isDark ? Colors.white : const Color(0xFF1C1C1E);
    final footerBg = isDark
        ? Colors.black.withValues(alpha: 0.2)
        : const Color(0xFFF9F9F9);
    final footerBorderColor = isDark
        ? Colors.white.withValues(alpha: 0.04)
        : const Color(0xFFE5E5EA);
    final cardBorderColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : const Color(0xFFE5E5EA);
    final shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.4)
        : Colors.black.withValues(alpha: 0.08);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0F0F1E), Color(0xFF1A1A2E)],
              )
            : null,
        color: isDark ? null : Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: cardBorderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: isDark ? 30 : 20,
            offset: Offset(0, isDark ? 15 : 8),
            spreadRadius: isDark ? -5 : -2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6C63FF).withValues(alpha: isDark ? 0.08 : 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Idiom principal
                  Text(
                    phrase.idiom,
                    style: TextStyle(
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      fontSize: 29.5,
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                      height: 1.15,
                      letterSpacing: -0.8,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // Pronunciación
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 14,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF4834DF)],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          phrase.pronunciation,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w400,
                            color: pronunciationColor,
                            letterSpacing: 0.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Contenido
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(28, 8, 28, 20),
                child: Column(
                  children: [
                    // Traducción literal
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: innerCardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: innerCardBorder, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF490DD3)
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.auto_stories,
                                  size: 16,
                                  color: Color(0xFF866BFF),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Traducción Literal',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: labelColor,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            '"${phrase.literalTranslation}"',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w400,
                              color: literalTextColor,
                              fontStyle: FontStyle.italic,
                              height: 1.6,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Significado real
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF6C63FF).withValues(alpha: isDark ? 0.12 : 0.10),
                            const Color(0xFF4834DF).withValues(alpha: isDark ? 0.08 : 0.06),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF6C63FF).withValues(alpha: 0.25),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6C63FF)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.psychology,
                                  size: 16,
                                  color: Color(0xFF6C63FF),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Significado real',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF6C63FF),
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            '"${phrase.spanish}"',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w600,
                              color: meaningTextColor,
                              height: 1.5,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer – botones
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              decoration: BoxDecoration(
                color: footerBg,
                border: Border(
                  top: BorderSide(color: footerBorderColor, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedVolumeButton(onTap: onSpeak),
                  const SizedBox(width: 12),
                  _ActionButton(
                    icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? const Color(0xFFFF6B6B) : null,
                    isActive: isFavorite,
                    isDark: isDark,
                    onTap: onToggleFavorite,
                  ),
                  const SizedBox(width: 12),
                  _ActionButton(
                    icon: Icons.share_outlined,
                    isDark: isDark,
                    onTap: onShare,
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    this.color,
    this.isActive = false,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = isDark
        ? Colors.white.withValues(alpha: 0.5)
        : const Color(0xFF6C6C70);
    final buttonColor = color ?? defaultColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: isActive
              ? buttonColor.withValues(alpha: 0.12)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.03)
                  : const Color(0xFFF2F2F7)),
          shape: BoxShape.circle,
          border: Border.all(
            color: isActive
                ? buttonColor.withValues(alpha: 0.3)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : const Color(0xFFE5E5EA)),
            width: 1,
          ),
        ),
        child: Icon(icon, color: buttonColor, size: 22),
      ),
    );
  }
}
