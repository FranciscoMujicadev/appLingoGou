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

        // Calcular la posición del highlight basado en xAlign y yAlign
        final highlightX = screenWidth * step.xAlign;
        final highlightY = screenHeight * step.yAlign;
        const highlightRadius = 60.0;

        return Stack(
          children: [
            // Fondo oscuro con agujero
            GestureDetector(
              onTap: () => provider.nextStep(),
              child: CustomPaint(
                painter: _HoleClipper(
                  centerX: highlightX,
                  centerY: highlightY,
                  radius: highlightRadius,
                ),
                child: Container(color: Colors.black.withOpacity(0.65)),
              ),
            ),
            // Caja de información
            Positioned(
              left: 20,
              right: 20,
              bottom: 80,
              child: GestureDetector(
                onTap: () {}, // Prevenir que se cierre al tocar la tarjeta
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A2332),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF00A8E8),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header con número de paso
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00A8E8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${provider.currentStep + 1}/${provider.steps.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => provider.skipGuideTour(),
                            child: const Text(
                              'Saltar guía',
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Título
                      Text(
                        step.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Descripción
                      Text(
                        step.description,
                        style: const TextStyle(
                          color: Color(0xFFB0B0B0),
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Botones
                      Row(
                        children: [
                          if (provider.currentStep > 0)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => provider.previousStep(),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFF00A8E8),
                                    width: 1.5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Anterior',
                                  style: TextStyle(
                                    color: Color(0xFF00A8E8),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          if (provider.currentStep > 0)
                            const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => provider.nextStep(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00A8E8),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                provider.currentStep ==
                                        provider.steps.length - 1
                                    ? 'Empezar'
                                    : 'Siguiente',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Flecha apuntando al highlight
            Positioned(
              left: highlightX - 10,
              top: highlightY - 20,
              child: Icon(
                Icons.arrow_upward,
                color: const Color(0xFF00A8E8),
                size: 24,
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
  final double radius;

  _HoleClipper({
    required this.centerX,
    required this.centerY,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.65);

    // Dibujar rectángulo completo
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Limpiar el área del círculo (agujero)
    canvas.drawCircle(
      Offset(centerX, centerY),
      radius,
      Paint()..blendMode = BlendMode.clear,
    );

    // Dibujar borde del círculo con brillo
    final borderPaint = Paint()
      ..color = const Color(0xFF00A8E8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, 8);

    canvas.drawCircle(Offset(centerX, centerY), radius, borderPaint);
  }

  @override
  bool shouldRepaint(_HoleClipper oldDelegate) {
    return oldDelegate.centerX != centerX ||
        oldDelegate.centerY != centerY ||
        oldDelegate.radius != radius;
  }
}
