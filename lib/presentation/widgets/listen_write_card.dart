// lib/presentation/widgets/listen_write_card.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/phrase_entity.dart';
import '../../core/utils/tts_service.dart';

class ListenWriteCard extends StatefulWidget {
  final PhraseEntity phrase;
  final VoidCallback onContinue;
  final VoidCallback onSkip;
  final VoidCallback? onCorrect;
  final VoidCallback? onWrong;

  const ListenWriteCard({
    super.key,
    required this.phrase,
    required this.onContinue,
    required this.onSkip,
    this.onCorrect,
    this.onWrong,
  });

  @override
  State<ListenWriteCard> createState() => _ListenWriteCardState();
}

class _ListenWriteCardState extends State<ListenWriteCard> {
  final TtsService _tts = TtsService();
  final TextEditingController _controller = TextEditingController();
  bool _hasChecked = false;
  bool _isCorrect = false;
  bool _isSpeaking = false;

  late String _targetText;
  late String _spanishHint;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _load();
    // Auto-play on enter
    WidgetsBinding.instance.addPostFrameCallback((_) => _speak(slow: false));
  }

  @override
  void didUpdateWidget(ListenWriteCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.phrase.id != widget.phrase.id) {
      _controller.clear();
      setState(() {
        _hasChecked = false;
        _isCorrect = false;
      });
      _load();
      _speak(slow: false);
    }
  }

  void _load() {
    final wordCount = widget.phrase.idiom.split(' ').length;
    if (wordCount <= 3) {
      // Frases cortas/fáciles: el usuario escucha y escribe el idiom directamente
      _targetText = widget.phrase.idiom;
      _spanishHint = widget.phrase.realMeaning;
    } else {
      // Frases intermedias/avanzadas: usa el ejemplo contextual completo
      final ex = widget.phrase.contextExamples.isNotEmpty
          ? widget.phrase.contextExamples[0]
          : null;
      _targetText = ex?.englishExample ?? widget.phrase.idiom;
      _spanishHint = ex?.spanishExample ?? widget.phrase.realMeaning;
    }
  }

  Future<void> _speak({required bool slow}) async {
    setState(() => _isSpeaking = true);
    try {
      if (slow) {
        await _tts.speakSlow(_targetText);
      } else {
        await _tts.speak(_targetText);
      }
    } finally {
      if (mounted) setState(() => _isSpeaking = false);
    }
  }

  String _normalize(String s) {
    return s
        .toLowerCase()
        .replaceAll(RegExp(r"[^\w\s']"), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  void _onCheck() {
    final typed = _normalize(_controller.text);
    final expected = _normalize(_targetText);
    setState(() {
      _hasChecked = true;
      _isCorrect = typed == expected;
    });
  }

  void _onContinue() {
    final wasCorrect = _isCorrect;
    _controller.clear();
    setState(() {
      _hasChecked = false;
      _isCorrect = false;
    });
    _load();
    if (wasCorrect) {
      widget.onCorrect?.call();
    } else {
      widget.onWrong?.call();
    }
    widget.onContinue();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0F0F1E) : const Color(0xFFF5F5F5);
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    final dividerColor =
        isDark ? const Color(0xFF2D2D4E) : const Color(0xFFE0E0E0);

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
                    'Escucha y escribe',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Character + audio buttons row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Character
                      _CharacterWidget(isDark: isDark),
                      const SizedBox(width: 20),
                      // Audio buttons
                      Column(
                        children: [
                          _AudioButton(
                            icon: Icons.volume_up_rounded,
                            label: 'Normal',
                            color: const Color(0xFF1CB0F6),
                            onTap: _isSpeaking ? null : () => _speak(slow: false),
                          ),
                          const SizedBox(height: 12),
                          _AudioButton(
                            icon: Icons.slow_motion_video_rounded,
                            label: 'Lento',
                            color: const Color(0xFF58CC02),
                            onTap: _isSpeaking ? null : () => _speak(slow: true),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Text input
                  _InputArea(
                    controller: _controller,
                    isDark: isDark,
                    hasChecked: _hasChecked,
                    isCorrect: _isCorrect,
                    enabled: !_hasChecked,
                  ),

                  // Feedback
                  if (_hasChecked) ...[
                    const SizedBox(height: 20),
                    _FeedbackBox(
                      isCorrect: _isCorrect,
                      correctText: _targetText,
                      spanishText: _spanishHint,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // ── Bottom bar ──
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F0F1E) : Colors.white,
              border: Border(
                  top: BorderSide(color: dividerColor, width: 1)),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                if (!_hasChecked)
                  TextButton(
                    onPressed: widget.onSkip,
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
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white54 : Colors.black38,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                if (!_hasChecked) const Spacer(),
                Expanded(
                  flex: _hasChecked ? 1 : 0,
                  child: _ActionButton(
                    hasChecked: _hasChecked,
                    isCorrect: _isCorrect,
                    canCheck: _controller.text.trim().isNotEmpty,
                    onCheck: _onCheck,
                    onContinue: _onContinue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Character
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
        color: isDark ? const Color(0xFF1E1E35) : const Color(0xFFE8F4FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF1CB0F6).withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFFFCBA4),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE8A87C), width: 1.5),
            ),
            child:
                const Center(child: Text('🎧', style: TextStyle(fontSize: 18))),
          ),
          const SizedBox(height: 4),
          Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFF1CB0F6),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 14,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF1899D6),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 14,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF1899D6),
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
// Audio button
// ─────────────────────────────────────────────

class _AudioButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _AudioButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: onTap == null ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: isDark
                ? color.withValues(alpha: 0.15)
                : color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color,
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
// Input area
// ─────────────────────────────────────────────

class _InputArea extends StatelessWidget {
  final TextEditingController controller;
  final bool isDark;
  final bool hasChecked;
  final bool isCorrect;
  final bool enabled;

  const _InputArea({
    required this.controller,
    required this.isDark,
    required this.hasChecked,
    required this.isCorrect,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    if (hasChecked) {
      borderColor = isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B);
    } else {
      borderColor = isDark ? const Color(0xFF2D2D4E) : const Color(0xFFE0E0E0);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: (hasChecked
                    ? (isCorrect
                        ? const Color(0xFF58CC02)
                        : const Color(0xFFFF4B4B))
                    : const Color(0xFF6C63FF))
                .withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        maxLines: 3,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF1A1A2E),
        ),
        decoration: InputDecoration(
          hintText: 'Escribe lo que escuchas...',
          hintStyle: GoogleFonts.inter(
            fontSize: 15,
            color: isDark ? Colors.white24 : Colors.black26,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Feedback box
// ─────────────────────────────────────────────

class _FeedbackBox extends StatelessWidget {
  final bool isCorrect;
  final String correctText;
  final String spanishText;

  const _FeedbackBox({
    required this.isCorrect,
    required this.correctText,
    required this.spanishText,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.highlight_off,
                color: color,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isCorrect ? '¡Bien hecho! Significa:' : 'La respuesta correcta:',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (!isCorrect) ...[
            Text(
              correctText,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
          ],
          Text(
            spanishText,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: color.withValues(alpha: 0.85),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Action button (COMPROBAR / CONTINUAR)
// ─────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final bool hasChecked;
  final bool isCorrect;
  final bool canCheck;
  final VoidCallback onCheck;
  final VoidCallback onContinue;

  const _ActionButton({
    required this.hasChecked,
    required this.isCorrect,
    required this.canCheck,
    required this.onCheck,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bg;
    Color fg;
    String label;

    if (!hasChecked) {
      bg = canCheck
          ? const Color(0xFF6C63FF)
          : (isDark ? const Color(0xFF2D2D4E) : const Color(0xFFE0E0E0));
      fg = canCheck
          ? Colors.white
          : (isDark ? Colors.white38 : Colors.black26);
      label = 'COMPROBAR';
    } else if (isCorrect) {
      bg = const Color(0xFF58CC02);
      fg = Colors.white;
      label = 'CONTINUAR';
    } else {
      bg = const Color(0xFFFF4B4B);
      fg = Colors.white;
      label = 'CONTINUAR';
    }

    return GestureDetector(
      onTap: hasChecked ? onContinue : (canCheck ? onCheck : null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: fg,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}
