// lib/presentation/widgets/business_scenario_card.dart
// Muestra UN escenario real de uso para un término de Business English.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/phrase_entity.dart';

class BusinessScenarioCard extends StatelessWidget {
  final ContextExampleEntity example;
  final String termName;
  final int scenarioIndex;
  final int totalScenarios;
  final VoidCallback onSpeak;
  final VoidCallback onContinue;

  const BusinessScenarioCard({
    super.key,
    required this.example,
    required this.termName,
    required this.scenarioIndex,
    required this.totalScenarios,
    required this.onSpeak,
    required this.onContinue,
  });

  /// Color de acento según el texto del contexto
  Color _accentColor() {
    final ctx = example.context.toLowerCase();
    if (ctx.contains('no') || ctx.contains('❌') || ctx.contains('nerv')) {
      return const Color(0xFFD32F2F); // rojo — lo que NO funciona
    }
    if (ctx.contains('sí') || ctx.contains('✅') || ctx.contains('correc')) {
      return const Color(0xFF2E7D32); // verde — lo que SÍ funciona
    }
    if (ctx.contains('por qué') || ctx.contains('analisis') || ctx.contains('análi')) {
      return const Color(0xFF6A1B9A); // morado — análisis
    }
    if (ctx.contains('email') || ctx.contains('correo')) {
      return const Color(0xFF0277BD); // azul — email
    }
    if (ctx.contains('reuni') || ctx.contains('meeting')) {
      return const Color(0xFF00695C); // teal — reunión
    }
    return const Color(0xFF0D47A1); // azul navy — por defecto (entrevista)
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = _accentColor();

    const navy = Color(0xFF0D1B2A);
    const gold = Color(0xFFD4A843);
    final bg = isDark ? const Color(0xFF0F1820) : const Color(0xFFF2F5FA);
    final textPrimary = isDark ? Colors.white : navy;
    final textMuted = isDark ? const Color(0xFF8E9BB0) : const Color(0xFF6C7A8D);
    final cardBg = isDark ? const Color(0xFF141F2B) : Colors.white;
    final cardBorder = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : const Color(0xFFDDE3EE);
    final esBg = isDark
        ? Colors.white.withValues(alpha: 0.03)
        : const Color(0xFFF8F9FB);
    final esBorder = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : const Color(0xFFE8ECF4);

    return Container(
      color: bg,
      child: SafeArea(
        child: Column(
          children: [
            // ── Barra superior: término + puntos de progreso ──────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
              child: Row(
                children: [
                  Text(
                    termName,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: textMuted,
                    ),
                  ),
                  const Spacer(),
                  // Puntos de progreso
                  Row(
                    children: List.generate(totalScenarios, (i) {
                      final active = i == scenarioIndex;
                      return Container(
                        width: active ? 22 : 7,
                        height: 7,
                        margin: const EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                          color: active
                              ? gold
                              : (isDark
                                  ? Colors.white.withValues(alpha: 0.15)
                                  : const Color(0xFFCCD4E0)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // ── Contenido central ─────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Card de inglés con categoría como header ──────────
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: cardBorder, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.06),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ▸ Header de categoría — IMPOSIBLE DE IGNORAR
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              decoration: BoxDecoration(
                                color: accent,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    example.emoji,
                                    style: const TextStyle(fontSize: 19.5),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      example.context,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ),
                                  // Bandera + label idioma
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.18),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('🇺🇸',
                                            style: TextStyle(fontSize: 12.5)),
                                        const SizedBox(width: 4),
                                        Text(
                                          'EN',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ▸ Frase en inglés
                            Padding(
                              padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                              child: _HighlightedText(
                                text: example.englishExample,
                                highlight: termName,
                                isDark: isDark,
                              ),
                            ),

                            // ▸ Pronunciación
                            Padding(
                              padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.black.withValues(alpha: 0.3)
                                      : const Color(0xFFF4F6FA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Icon(Icons.record_voice_over_rounded,
                                          size: 14, color: accent),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        example.pronunciation,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12.5,
                                          color: textMuted,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: GestureDetector(
                                        onTap: onSpeak,
                                        child: Icon(Icons.volume_up_rounded,
                                            size: 18, color: accent),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Traducción al español ─────────────────────────────
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: esBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: esBorder, width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header español
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.04)
                                    : const Color(0xFFEEF1F7),
                                border: Border(
                                  bottom: BorderSide(
                                      color: esBorder, width: 1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Text('🇲🇽',
                                      style: TextStyle(fontSize: 13.5)),
                                  const SizedBox(width: 8),
                                  Text(
                                    'En español',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w700,
                                      color: textMuted,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18),
                              child: Text(
                                example.spanishExample,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w600,
                                  color: textPrimary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ── Botón continuar ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: SizedBox(
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
                        scenarioIndex < totalScenarios - 1
                            ? 'Siguiente escenario'
                            : 'Hacer práctica',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        scenarioIndex < totalScenarios - 1
                            ? Icons.arrow_forward_rounded
                            : Icons.quiz_rounded,
                        size: 18,
                      ),
                    ],
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

/// Resalta el término dentro de la frase en inglés.
class _HighlightedText extends StatelessWidget {
  final String text;
  final String highlight;
  final bool isDark;

  const _HighlightedText({
    required this.text,
    required this.highlight,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final keyword = highlight.split(' ').first.toLowerCase();
    final lowerText = text.toLowerCase();
    final idx = lowerText.indexOf(keyword);

    final baseStyle = GoogleFonts.plusJakartaSans(
      fontSize: 18.5,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.white : const Color(0xFF0D1B2A),
      height: 1.55,
    );

    if (idx == -1 || keyword.length < 3) {
      return Text(text, style: baseStyle);
    }

    final before = text.substring(0, idx);
    final match = text.substring(idx, idx + keyword.length);
    final after = text.substring(idx + keyword.length);

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: before),
          TextSpan(
            text: match,
            style: baseStyle.copyWith(
              backgroundColor: const Color(0xFFD4A843).withValues(alpha: 0.25),
              color: isDark ? const Color(0xFFF0C060) : const Color(0xFF7A5200),
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(text: after),
        ],
      ),
    );
  }
}
