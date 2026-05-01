// lib/presentation/widgets/quiz_card.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/phrase_entity.dart';
import 'shared/quiz_utils.dart';

class QuizCard extends StatefulWidget {
  final PhraseEntity phrase;
  final List<PhraseEntity> allPhrases;
  final VoidCallback onContinue;
  final VoidCallback onSkip;
  final VoidCallback? onCorrect;
  final VoidCallback? onWrong;

  const QuizCard({
    super.key,
    required this.phrase,
    required this.allPhrases,
    required this.onContinue,
    required this.onSkip,
    this.onCorrect,
    this.onWrong,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard>
    with SingleTickerProviderStateMixin {
  int? _selectedIndex;
  bool _hasChecked = false;
  late List<_QuizOption> _options;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
    _buildOptions();
  }

  @override
  void didUpdateWidget(QuizCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.phrase.id != widget.phrase.id) {
      setState(() {
        _selectedIndex = null;
        _hasChecked = false;
      });
      _buildOptions();
    }
  }

  void _buildOptions() {
    final correct = widget.phrase.realMeaning;
    final correctKw = quizKeywords(correct);

    final others = widget.allPhrases
        .where((p) => p.id != widget.phrase.id)
        .toList()
      ..shuffle(Random());

    final wrongs = <String>[];
    for (final p in others) {
      if (wrongs.length >= 2) break;
      final candidate = p.realMeaning;
      final candidateKw = quizKeywords(candidate);
      // Skip if too similar to the correct answer or to already-chosen distractors
      if (jaccardSimilarity(correctKw, candidateKw) > 0.35) continue;
      if (wrongs.any((w) => jaccardSimilarity(quizKeywords(w), candidateKw) > 0.35)) continue;
      wrongs.add(candidate);
    }
    // Fallback: fill remaining slots without similarity filter
    for (final p in others) {
      if (wrongs.length >= 2) break;
      final candidate = p.realMeaning;
      if (candidate != correct && !wrongs.contains(candidate)) {
        wrongs.add(candidate);
      }
    }

    final all = [correct, ...wrongs.take(2)]..shuffle(Random());
    _options = all
        .map((m) => _QuizOption(text: m, isCorrect: m == correct))
        .toList();
  }

  bool get _isCorrectSelected =>
      _selectedIndex != null && _options[_selectedIndex!].isCorrect;

  void _onCheck() {
    if (_selectedIndex == null) return;
    setState(() => _hasChecked = true);
    if (!_isCorrectSelected) {
      _shakeController.forward(from: 0);
    }
  }

  void _onContinue() {
    final wasCorrect = _isCorrectSelected;
    setState(() {
      _selectedIndex = null;
      _hasChecked = false;
    });
    _buildOptions();
    if (wasCorrect) {
      widget.onCorrect?.call();
    } else {
      widget.onWrong?.call();
    }
    widget.onContinue();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0F0F1E) : const Color(0xFFF5F5F5);
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);

    return Container(
      color: bg,
      child: Column(
        children: [
          // ── Content ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Escoge el significado correcto',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 21.5,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Character + bubble
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Character
                      _CharacterWidget(isDark: isDark),
                      const SizedBox(width: 12),
                      // Speech bubble
                      Flexible(
                        child: _SpeechBubble(
                          text: widget.phrase.idiom,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // Options
                  ...List.generate(_options.length, (i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _OptionButton(
                        index: i,
                        text: _options[i].text,
                        isSelected: _selectedIndex == i,
                        isCorrect: _options[i].isCorrect,
                        hasChecked: _hasChecked,
                        shakeAnimation:
                            (_hasChecked && _selectedIndex == i && !_options[i].isCorrect)
                                ? _shakeAnimation
                                : null,
                        onTap: _hasChecked
                            ? null
                            : () => setState(() => _selectedIndex = i),
                      ),
                    );
                  }),

                  // Feedback banner
                  if (_hasChecked) ...[
                    const SizedBox(height: 8),
                    _FeedbackBanner(isCorrect: _isCorrectSelected),
                  ],
                ],
              ),
            ),
          ),

          // ── Bottom bar ──
          _BottomBar(
            hasChecked: _hasChecked,
            selectedIndex: _selectedIndex,
            isCorrect: _isCorrectSelected,
            isDark: isDark,
            onSkip: widget.onSkip,
            onCheck: _onCheck,
            onContinue: _onContinue,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Character illustration
// ─────────────────────────────────────────────

class _CharacterWidget extends StatelessWidget {
  final bool isDark;
  const _CharacterWidget({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 110,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E1E35)
            : const Color(0xFFE8E4FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Head
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFFFCBA4),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFE8A87C),
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Text('😊', style: TextStyle(fontSize: 19.5)),
            ),
          ),
          const SizedBox(height: 4),
          // Body
          Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 2),
          // Legs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 14,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF4834DF),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 14,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF4834DF),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Speech bubble
// ─────────────────────────────────────────────

class _SpeechBubble extends StatelessWidget {
  final String text;
  final bool isDark;
  const _SpeechBubble({required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E35) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17.5,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF1A1A2E),
            ),
          ),
        ),
        // Tail
        Positioned(
          left: -10,
          bottom: 14,
          child: CustomPaint(
            painter: _BubbleTailPainter(
              color: isDark ? const Color(0xFF1E1E35) : Colors.white,
              borderColor:
                  const Color(0xFF6C63FF).withValues(alpha: 0.4),
            ),
            size: const Size(12, 14),
          ),
        ),
      ],
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  const _BubbleTailPainter({required this.color, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill;
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, size.height / 2)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, borderPaint);
    final innerPath = Path()
      ..moveTo(size.width, 1.5)
      ..lineTo(1.5, size.height / 2)
      ..lineTo(size.width, size.height - 1.5)
      ..close();
    canvas.drawPath(innerPath, fillPaint);
  }

  @override
  bool shouldRepaint(_BubbleTailPainter old) =>
      old.color != color || old.borderColor != borderColor;
}

// ─────────────────────────────────────────────
// Option button
// ─────────────────────────────────────────────

class _OptionButton extends StatelessWidget {
  final int index;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool hasChecked;
  final Animation<double>? shakeAnimation;
  final VoidCallback? onTap;

  const _OptionButton({
    required this.index,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.hasChecked,
    this.shakeAnimation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color borderColor;
    Color bgColor;
    Color textColor;
    Color badgeColor;

    if (hasChecked && isSelected) {
      if (isCorrect) {
        borderColor = const Color(0xFF58CC02);
        bgColor = const Color(0xFF58CC02).withValues(alpha: 0.15);
        textColor = const Color(0xFF58CC02);
        badgeColor = const Color(0xFF58CC02);
      } else {
        borderColor = const Color(0xFFFF4B4B);
        bgColor = const Color(0xFFFF4B4B).withValues(alpha: 0.15);
        textColor = const Color(0xFFFF4B4B);
        badgeColor = const Color(0xFFFF4B4B);
      }
    } else if (hasChecked && isCorrect) {
      // Show correct answer even if not selected
      borderColor = const Color(0xFF58CC02).withValues(alpha: 0.5);
      bgColor = const Color(0xFF58CC02).withValues(alpha: 0.08);
      textColor = isDark ? Colors.white70 : Colors.black54;
      badgeColor = const Color(0xFF58CC02).withValues(alpha: 0.5);
    } else if (isSelected) {
      borderColor = const Color(0xFF6C63FF);
      bgColor = const Color(0xFF6C63FF).withValues(alpha: 0.12);
      textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
      badgeColor = const Color(0xFF6C63FF);
    } else {
      borderColor = isDark
          ? const Color(0xFF2D2D4E)
          : const Color(0xFFE0E0E0);
      bgColor = isDark ? const Color(0xFF1A1A2E) : Colors.white;
      textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
      badgeColor = isDark
          ? const Color(0xFF2D2D4E)
          : const Color(0xFFE0E0E0);
    }

    Widget button = GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            // Number badge
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: badgeColor, width: 1.5),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: badgeColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Answer text
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            // Check/X icon after checking
            if (hasChecked && isSelected)
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect
                    ? const Color(0xFF58CC02)
                    : const Color(0xFFFF4B4B),
                size: 22,
              ),
          ],
        ),
      ),
    );

    if (shakeAnimation != null) {
      return AnimatedBuilder(
        animation: shakeAnimation!,
        builder: (context, child) {
          final offset =
              sin(shakeAnimation!.value * pi * 4) * 8;
          return Transform.translate(
            offset: Offset(offset, 0),
            child: child,
          );
        },
        child: button,
      );
    }
    return button;
  }
}

// ─────────────────────────────────────────────
// Feedback banner
// ─────────────────────────────────────────────

class _FeedbackBanner extends StatelessWidget {
  final bool isCorrect;
  const _FeedbackBanner({required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isCorrect
            ? const Color(0xFF58CC02).withValues(alpha: 0.15)
            : const Color(0xFFFF4B4B).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCorrect
              ? const Color(0xFF58CC02)
              : const Color(0xFFFF4B4B),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCorrect ? Icons.check_circle_outline : Icons.highlight_off,
            color: isCorrect
                ? const Color(0xFF58CC02)
                : const Color(0xFFFF4B4B),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isCorrect
                  ? '¡Correcto! Muy bien.'
                  : '¡Casi! Sigue practicando.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: isCorrect
                    ? const Color(0xFF58CC02)
                    : const Color(0xFFFF4B4B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bottom action bar
// ─────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  final bool hasChecked;
  final int? selectedIndex;
  final bool isCorrect;
  final bool isDark;
  final VoidCallback onSkip;
  final VoidCallback onCheck;
  final VoidCallback onContinue;

  const _BottomBar({
    required this.hasChecked,
    required this.selectedIndex,
    required this.isCorrect,
    required this.isDark,
    required this.onSkip,
    required this.onCheck,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final dividerColor =
        isDark ? const Color(0xFF2D2D4E) : const Color(0xFFE0E0E0);
    final skipTextColor =
        isDark ? Colors.white54 : Colors.black38;

    Color actionBg;
    Color actionText;
    String actionLabel;

    if (!hasChecked) {
      final canCheck = selectedIndex != null;
      actionBg = canCheck
          ? const Color(0xFF6C63FF)
          : (isDark
              ? const Color(0xFF2D2D4E)
              : const Color(0xFFE0E0E0));
      actionText = canCheck
          ? Colors.white
          : (isDark ? Colors.white38 : Colors.black26);
      actionLabel = 'COMPROBAR';
    } else if (isCorrect) {
      actionBg = const Color(0xFF58CC02);
      actionText = Colors.white;
      actionLabel = 'CONTINUAR';
    } else {
      actionBg = const Color(0xFFFF4B4B);
      actionText = Colors.white;
      actionLabel = 'CONTINUAR';
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F0F1E) : Colors.white,
        border: Border(
          top: BorderSide(color: dividerColor, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // SALTAR button
          if (!hasChecked)
            TextButton(
              onPressed: onSkip,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: dividerColor, width: 1.5),
                ),
              ),
              child: Text(
                'SALTAR',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: skipTextColor,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          if (!hasChecked) const Spacer(),

          // COMPROBAR / CONTINUAR button
          Expanded(
            flex: hasChecked ? 1 : 0,
            child: GestureDetector(
              onTap: hasChecked
                  ? onContinue
                  : (selectedIndex != null ? onCheck : null),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: actionBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  actionLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: actionText,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────

class _QuizOption {
  final String text;
  final bool isCorrect;
  const _QuizOption({required this.text, required this.isCorrect});
}