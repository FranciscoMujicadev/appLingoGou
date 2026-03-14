// lib/presentation/widgets/lingo_mascot.dart

import 'package:flutter/material.dart';

/// Widget de mascota "Lingo" — un búho estilizado para onboarding y UI.
class LingoMascot extends StatelessWidget {
  final double size;
  const LingoMascot({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LingoOwlPainter(),
      ),
    );
  }
}

class _LingoOwlPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    // ── Body ──
    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [const Color(0xFF6C63FF), const Color(0xFF4F46E5)],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r));
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy * 1.05), width: r * 1.6, height: r * 1.8),
      bodyPaint,
    );

    // ── Belly ──
    final bellyPaint = Paint()..color = const Color(0xFFE0E7FF);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy * 1.25),
        width: r * 1.0,
        height: r * 1.0,
      ),
      bellyPaint,
    );

    // ── Eyes (white) ──
    final eyeWhite = Paint()..color = Colors.white;
    final eyeR = r * 0.28;
    final eyeLx = cx - r * 0.28;
    final eyeRx = cx + r * 0.28;
    final eyeY = cy * 0.78;
    canvas.drawCircle(Offset(eyeLx, eyeY), eyeR, eyeWhite);
    canvas.drawCircle(Offset(eyeRx, eyeY), eyeR, eyeWhite);

    // ── Pupils ──
    final pupil = Paint()..color = const Color(0xFF1E1B4B);
    final pupilR = r * 0.14;
    canvas.drawCircle(Offset(eyeLx, eyeY), pupilR, pupil);
    canvas.drawCircle(Offset(eyeRx, eyeY), pupilR, pupil);

    // ── Eye shine ──
    final shine = Paint()..color = Colors.white;
    final shineR = r * 0.05;
    canvas.drawCircle(Offset(eyeLx - pupilR * 0.3, eyeY - pupilR * 0.3), shineR, shine);
    canvas.drawCircle(Offset(eyeRx - pupilR * 0.3, eyeY - pupilR * 0.3), shineR, shine);

    // ── Beak ──
    final beak = Paint()..color = const Color(0xFFFBBF24);
    final beakPath = Path()
      ..moveTo(cx - r * 0.1, cy * 0.95)
      ..lineTo(cx, cy * 1.08)
      ..lineTo(cx + r * 0.1, cy * 0.95)
      ..close();
    canvas.drawPath(beakPath, beak);

    // ── Ear tufts ──
    final tuft = Paint()
      ..color = const Color(0xFF4F46E5)
      ..strokeWidth = r * 0.08
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(cx - r * 0.4, cy * 0.55),
      Offset(cx - r * 0.55, cy * 0.3),
      tuft,
    );
    canvas.drawLine(
      Offset(cx + r * 0.4, cy * 0.55),
      Offset(cx + r * 0.55, cy * 0.3),
      tuft,
    );

    // ── Feet ──
    final feet = Paint()..color = const Color(0xFFFBBF24);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - r * 0.2, cy * 1.9), width: r * 0.3, height: r * 0.12),
      feet,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + r * 0.2, cy * 1.9), width: r * 0.3, height: r * 0.12),
      feet,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
