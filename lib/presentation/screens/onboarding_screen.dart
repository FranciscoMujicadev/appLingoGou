// lib/presentation/screens/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/analytics_service.dart';
import '../../core/utils/onboarding_storage.dart';
import 'main_navigation_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  int _step = 0;
  String? _selectedGoal;
  String? _selectedTime;
  String? _selectedLevel;
  String? _selectedSource;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  static const _goals = [
    ('Viajes', '✈️'),
    ('Trabajo', '💼'),
    ('Conversación', '🗣️'),
    ('Entretenimiento', '🎬'),
  ];

  static const List<(String, String)> _times = [
    ('3 min/día', 'Relajado'),
    ('10 min/día', 'Normal'),
    ('15 min/día', 'Serio'),
    ('30 min/día', 'Intenso'),
  ];

  static const _levels = [
    ('Principiante', '🌱'),
    ('Básico', '📚'),
    ('Intermedio', '⭐'),
    ('Avanzado', '🚀'),
  ];

  static const _sources = [
    ('App Store / Play Store', '📱'),
    ('Facebook / Instagram', '📘'),
    ('TikTok', '🎵'),
    ('Búsqueda en Google', '🔍'),
    ('Amigos / familia', '👥'),
    ('YouTube', '▶️'),
    ('TV / Publicidad', '📺'),
    ('Otro', '✨'),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  bool get _canContinue {
    if (_step == 0) return true;
    if (_step == 1) return _selectedGoal != null;
    if (_step == 2) return _selectedTime != null;
    if (_step == 3) return _selectedLevel != null;
    return _selectedSource != null;
  }

  void _goNext() {
    if (!_canContinue) return;
    if (_step < 4) {
      _fadeController.forward(from: 0);
      setState(() => _step++);
    } else {
      _complete();
    }
  }

  void _goBack() {
    if (_step == 0) return;
    _fadeController.forward(from: 0);
    setState(() => _step--);
  }

  Future<void> _complete() async {
    await OnboardingStorage.setOnboardingCompleted(
      goal: _selectedGoal,
      time: _selectedTime,
      level: _selectedLevel,
      source: _selectedSource,
    );
    if (_selectedGoal != null && _selectedTime != null && _selectedLevel != null) {
      await AnalyticsService.logOnboardingCompleted(
        goal: _selectedGoal!,
        studyTime: _selectedTime!,
        level: _selectedLevel!,
        source: _selectedSource,
      );
    }
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(
            children: [
              // ── Top bar ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    if (_step > 0)
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Color(0xFF4B4B4B), size: 24),
                        onPressed: _goBack,
                      )
                    else
                      const SizedBox(width: 48),
                    const Spacer(),
                    Row(
                      children: List.generate(5, (i) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _step == i ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _step >= i
                                ? const Color(0xFF58CC02)
                                : const Color(0xFFE5E5E5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // ── Content ──
              Expanded(
                child: _step == 0
                    ? const _IntroStep()
                    : _step == 1
                        ? _OptionStep(
                            question: '¿Cuál es tu meta con el inglés?',
                            options: _goals,
                            selected: _selectedGoal,
                            onSelect: (v) =>
                                setState(() => _selectedGoal = v),
                          )
                        : _step == 2
                            ? _TimeGoalStep(
                                options: _times,
                                selected: _selectedTime,
                                onSelect: (v) =>
                                    setState(() => _selectedTime = v),
                              )
                            : _step == 3
                                ? _OptionStep(
                                    question:
                                        '¿Cuál es tu nivel actual de inglés?',
                                    options: _levels,
                                    selected: _selectedLevel,
                                    onSelect: (v) =>
                                        setState(() => _selectedLevel = v),
                                  )
                                : _OptionStep(
                                    question:
                                        '¿Cómo supiste de LingoGou?',
                                    options: _sources,
                                    selected: _selectedSource,
                                    onSelect: (v) =>
                                        setState(() => _selectedSource = v),
                                  ),
              ),

              // ── CONTINUAR button ──
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: GestureDetector(
                  onTap: _canContinue ? _goNext : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: _canContinue
                          ? const Color(0xFF58CC02)
                          : const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: _canContinue
                          ? [
                              BoxShadow(
                                color: const Color(0xFF58CC02)
                                    .withValues(alpha: 0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _step == 4 ? '¡EMPEZAR!' : 'CONTINUAR',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: _canContinue
                            ? Colors.white
                            : const Color(0xFFAAAAAA),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
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
// Intro Step
// ─────────────────────────────────────────────

class _IntroStep extends StatelessWidget {
  const _IntroStep();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: _SpeechBubble(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17.5,
                  color: const Color(0xFF333333),
                  height: 1.45,
                ),
                children: const [
                  TextSpan(
                      text:
                          '¡Vamos a crear tu primera lección!\nPero primero, responde '),
                  TextSpan(
                    text: 'estas preguntas cortas',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const _LingoMascot(size: 180),
        const Spacer(flex: 3),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Option Step
// ─────────────────────────────────────────────

class _OptionStep extends StatelessWidget {
  final String question;
  final List<(String, String)> options;
  final String? selected;
  final void Function(String) onSelect;

  const _OptionStep({
    required this.question,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _LingoMascot(size: 72),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  question,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF333333),
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          ...options.map((opt) {
            final (label, emoji) = opt;
            final isSelected = selected == label;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => onSelect(label),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFDDF4C1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF58CC02)
                          : const Color(0xFFE0E0E0),
                      width: isSelected ? 2.5 : 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(emoji, style: const TextStyle(fontSize: 23.5)),
                      const SizedBox(width: 16),
                      Text(
                        label,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? const Color(0xFF3A8C00)
                              : const Color(0xFF333333),
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        const Icon(Icons.check_circle,
                            color: Color(0xFF58CC02), size: 22),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Time Goal Step
// ─────────────────────────────────────────────

class _TimeGoalStep extends StatelessWidget {
  final List<(String, String)> options;
  final String? selected;
  final void Function(String) onSelect;

  const _TimeGoalStep({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _LingoMascot(size: 72),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  '¿Cuál es tu meta diaria de aprendizaje?',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF333333),
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          ...options.map((opt) {
            final (time, intensity) = opt;
            final isSelected = selected == time;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => onSelect(time),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFDDF4C1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF58CC02)
                          : const Color(0xFFE0E0E0),
                      width: isSelected ? 2.5 : 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        time,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w800,
                          color: isSelected
                              ? const Color(0xFF3A8C00)
                              : const Color(0xFF1A1A1A),
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        const Icon(Icons.check_circle,
                            color: Color(0xFF58CC02), size: 22)
                      else
                        Text(
                          intensity,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFAAAAAA),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Speech Bubble
// ─────────────────────────────────────────────

class _SpeechBubble extends StatelessWidget {
  final Widget child;
  const _SpeechBubble({required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.07),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
        CustomPaint(
          size: const Size(24, 14),
          painter: _BubbleTailPainter(),
        ),
      ],
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, borderPaint);

    final innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final innerPath = Path()
      ..moveTo(1.5, 0)
      ..lineTo(size.width - 1.5, 0)
      ..lineTo(size.width / 2, size.height - 2)
      ..close();
    canvas.drawPath(innerPath, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────
// LingoGou Mascot (purple blob character)
// ─────────────────────────────────────────────

class _LingoMascot extends StatelessWidget {
  final double size;
  const _LingoMascot({this.size = 160});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _LingoMascotPainter()),
    );
  }
}

class _LingoMascotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    const bodyColor = Color(0xFF4B2A8C);
    final bodyPaint = Paint()..color = bodyColor;

    // ── Shadow under feet ──
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, h * 0.955),
        width: w * 0.52,
        height: h * 0.05,
      ),
      Paint()..color = const Color(0x33000000),
    );

    // ── Blob body (single continuous path) ──
    // Traced to match reference: rounded top dome, widens at mid-body,
    // two small rounded feet at bottom with slight dip between them.
    final blob = Path();

    blob.moveTo(cx, h * 0.05); // top center

    // Top-right curve
    blob.cubicTo(
      cx + w * 0.28, h * 0.04,
      cx + w * 0.40, h * 0.13,
      cx + w * 0.40, h * 0.27,
    );

    // Right body — bulges out slightly at mid
    blob.cubicTo(
      cx + w * 0.43, h * 0.40,
      cx + w * 0.42, h * 0.55,
      cx + w * 0.37, h * 0.67,
    );

    // Right foot
    blob.cubicTo(
      cx + w * 0.34, h * 0.76,
      cx + w * 0.35, h * 0.83,
      cx + w * 0.26, h * 0.88,
    );
    blob.cubicTo(
      cx + w * 0.18, h * 0.93,
      cx + w * 0.08, h * 0.93,
      cx + w * 0.04, h * 0.88,
    );

    // Dip between feet
    blob.cubicTo(
      cx + w * 0.01, h * 0.84,
      cx - w * 0.01, h * 0.84,
      cx - w * 0.04, h * 0.88,
    );

    // Left foot
    blob.cubicTo(
      cx - w * 0.08, h * 0.93,
      cx - w * 0.18, h * 0.93,
      cx - w * 0.26, h * 0.88,
    );
    blob.cubicTo(
      cx - w * 0.35, h * 0.83,
      cx - w * 0.34, h * 0.76,
      cx - w * 0.37, h * 0.67,
    );

    // Left body — mirrors right
    blob.cubicTo(
      cx - w * 0.42, h * 0.55,
      cx - w * 0.43, h * 0.40,
      cx - w * 0.40, h * 0.27,
    );

    // Top-left curve
    blob.cubicTo(
      cx - w * 0.40, h * 0.13,
      cx - w * 0.28, h * 0.04,
      cx, h * 0.05,
    );

    blob.close();
    canvas.drawPath(blob, bodyPaint);

    // ── Left arm (small rounded shape pressed against body side) ──
    canvas.save();
    canvas.translate(cx - w * 0.43, h * 0.50);
    canvas.rotate(-0.18);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: w * 0.15,
        height: h * 0.19,
      ),
      bodyPaint,
    );
    canvas.restore();

    // ── Right arm ──
    canvas.save();
    canvas.translate(cx + w * 0.43, h * 0.50);
    canvas.rotate(0.18);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: w * 0.15,
        height: h * 0.19,
      ),
      bodyPaint,
    );
    canvas.restore();

    // ── Orange belly patch ──
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, h * 0.66),
        width: w * 0.44,
        height: h * 0.26,
      ),
      Paint()..color = const Color(0xFFE87D18),
    );

    // ── Eyes (dark oval, slightly wide) ──
    final eyePaint = Paint()..color = const Color(0xFF1A0830);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - w * 0.095, h * 0.295),
        width: w * 0.115,
        height: h * 0.095,
      ),
      eyePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx + w * 0.095, h * 0.295),
        width: w * 0.115,
        height: h * 0.095,
      ),
      eyePaint,
    );

    // ── Eye shine dots ──
    final shine = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(cx - w * 0.068, h * 0.277), w * 0.022, shine);
    canvas.drawCircle(Offset(cx + w * 0.122, h * 0.277), w * 0.022, shine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
