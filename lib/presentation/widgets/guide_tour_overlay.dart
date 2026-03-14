import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/guide_tour_provider.dart';

class GuideTourOverlay extends StatelessWidget {
  const GuideTourOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GuideTourProvider>(
      builder: (context, provider, _) {
        if (!provider.isGuideTourActive) {
          return const SizedBox.shrink();
        }

        final step = provider.steps[provider.currentStep];
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        final highlightX = screenWidth * step.xAlign;
        final highlightY = screenHeight * step.yAlign;
        final highlightWidth = step.width;
        final highlightHeight = step.height;

        return Stack(
          children: [
            // Dark overlay with hole
            GestureDetector(
              onTap: () => provider.nextStep(),
              child: CustomPaint(
                painter: _HoleClipper(
                  centerX: highlightX,
                  centerY: highlightY,
                  width: highlightWidth,
                  height: highlightHeight,
                ),
                child: Container(color: Colors.transparent),
              ),
            ),


            // Info Box
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              left: 24,
              right: 24,
              top: step.boxAtTop ? 60 : null,
              bottom: step.boxAtTop ? null : 120,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    border: const Border(
                      bottom: BorderSide(color: Color(0xFF6366F1), width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 50,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'PASO ${provider.currentStep + 1} DE ${provider.steps.length}',
                              style: const TextStyle(
                                color: Color(0xFF6366F1),
                                fontWeight: FontWeight.w900,
                                fontSize: 10,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => provider.skipGuideTour(),
                            icon: const Icon(Icons.close,
                                color: Color(0xFFD1D5DB), size: 20),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        step.title,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        step.description,
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Progress dots
                          Row(
                            children: List.generate(provider.steps.length, (i) {
                              final isActive = i == provider.currentStep;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(right: 6),
                                height: 6,
                                width: isActive ? 32 : 6,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? const Color(0xFF6366F1)
                                      : const Color(0xFFE5E7EB),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              );
                            }),
                          ),
                          // Buttons
                          Row(
                            children: [
                              if (provider.currentStep > 0)
                                TextButton(
                                  onPressed: () => provider.previousStep(),
                                  child: const Text(
                                    'Atrás',
                                    style: TextStyle(
                                      color: Color(0xFF9CA3AF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => provider.nextStep(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4F46E5),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  elevation: 4,
                                  shadowColor: const Color(0xFF6366F1)
                                      .withValues(alpha: 0.3),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      provider.currentStep ==
                                              provider.steps.length - 1
                                          ? 'Entendido'
                                          : 'Siguiente',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.chevron_right, size: 16),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HoleClipper extends CustomPainter {
  final double centerX;
  final double centerY;
  final double width;
  final double height;

  _HoleClipper({
    required this.centerX,
    required this.centerY,
    required this.width,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: 0.4);

    final highlightRect = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: width,
      height: height,
    );
    final roundedRect = RRect.fromRectAndRadius(
      highlightRect,
      const Radius.circular(16),
    );

    // Overlay path with hole
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(roundedRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);

    // Highlight ring
    final ringPaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    
    // Smooth transition shadow for highlight
    final glowPaint = Paint()
      ..color = const Color(0xFF3B82F6).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final ringRect = RRect.fromRectAndRadius(
      highlightRect.inflate(2),
      const Radius.circular(18),
    );

    final glowRect = RRect.fromRectAndRadius(
      highlightRect.inflate(4),
      const Radius.circular(20),
    );

    canvas.drawRRect(glowRect, glowPaint);
    canvas.drawRRect(ringRect, ringPaint);
  }

  @override
  bool shouldRepaint(_HoleClipper oldDelegate) {
    return oldDelegate.centerX != centerX ||
        oldDelegate.centerY != centerY ||
        oldDelegate.width != width ||
        oldDelegate.height != height;
  }
}

