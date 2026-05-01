// lib/presentation/screens/premium_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/premium_provider.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PremiumScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0A0A15) : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
      child: Consumer<PremiumProvider>(
        builder: (context, premium, _) {
          if (premium.isPremium) {
            return _PremiumActiveView(isDark: isDark);
          }
          return _UpgradeView(isDark: isDark, premium: premium);
        },
      ),
    );
  }
}

// ─── Ya es Premium ───────────────────────────────────────────────────────────

class _PremiumActiveView extends StatelessWidget {
  final bool isDark;
  const _PremiumActiveView({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : const Color(0xFF1C1C1E);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 32),
        const Text('👑', style: TextStyle(fontSize: 55.5)),
        const SizedBox(height: 16),
        Text(
          '¡Eres Premium!',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 25.5,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFFFC107),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Disfrutas de LingoGou sin anuncios.',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.5,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cerrar',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15.5,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Pantalla de compra ───────────────────────────────────────────────────────

class _UpgradeView extends StatelessWidget {
  final bool isDark;
  final PremiumProvider premium;
  const _UpgradeView({required this.isDark, required this.premium});

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : const Color(0xFF1C1C1E);
    final subColor = isDark ? Colors.white60 : Colors.black54;

    // Precio: usar el real de la tienda si está disponible
    final priceLabel = premium.product?.price ?? '\$29.99 MXN';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Handle
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 28),

        // Crown + title
        const Text('👑', style: TextStyle(fontSize: 51.5)),
        const SizedBox(height: 12),
        Text(
          'LingoGou Premium',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 23.5,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFFFC107),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Aprende inglés sin interrupciones',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.5,
            color: subColor,
          ),
        ),
        const SizedBox(height: 24),

        // Beneficios
        _Benefit(
          icon: Icons.block_rounded,
          text: 'Sin anuncios',
          isDark: isDark,
        ),
        const SizedBox(height: 10),
        _Benefit(
          icon: Icons.all_inclusive_rounded,
          text: 'Acceso ilimitado a todas las lecciones',
          isDark: isDark,
        ),
        const SizedBox(height: 10),
        _Benefit(
          icon: Icons.support_agent_rounded,
          text: 'Soporte prioritario',
          isDark: isDark,
        ),
        const SizedBox(height: 28),

        // Precio
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFC107).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFFFC107).withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                priceLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 27.5,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '/ mes',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.5,
                  color: subColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Botón de compra
        if (premium.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              premium.errorMessage!,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
                color: Colors.redAccent,
              ),
            ),
          ),

        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: premium.isLoading ? null : () => premium.buyPremium(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC107),
              foregroundColor: Colors.black,
              disabledBackgroundColor: const Color(0xFFFFC107).withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: premium.isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.black,
                    ),
                  )
                : Text(
                    'Obtener Premium',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),

        // Restaurar compras
        TextButton(
          onPressed: premium.isLoading ? null : () => premium.restorePurchases(),
          child: Text(
            'Restaurar compras',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5,
              color: subColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),

        const SizedBox(height: 4),
        Text(
          'La suscripción se renueva automáticamente. Cancela cuando quieras.',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10.5,
            color: subColor,
          ),
        ),
      ],
    );
  }
}

class _Benefit extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;
  const _Benefit({required this.icon, required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFFFC107).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFFFFC107), size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF1C1C1E),
            ),
          ),
        ),
        const Icon(Icons.check_circle_rounded, color: Color(0xFF58CC02), size: 20),
      ],
    );
  }
}
