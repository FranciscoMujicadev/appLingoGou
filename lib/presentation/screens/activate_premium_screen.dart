// lib/presentation/screens/activate_premium_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/premium_provider.dart';
import '../../providers/ad_provider.dart';

class ActivatePremiumScreen extends StatefulWidget {
  const ActivatePremiumScreen({super.key});

  @override
  State<ActivatePremiumScreen> createState() => _ActivatePremiumScreenState();
}

class _ActivatePremiumScreenState extends State<ActivatePremiumScreen> {
  final _controller = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onActivate() async {
    setState(() => _errorMessage = null);
    FocusScope.of(context).unfocus();

    final premium = context.read<PremiumProvider>();
    final result = await premium.activate(_controller.text);

    if (!mounted) return;

    if (result.success) {
      context.read<AdProvider>().setPremium(true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Premium activado! ${result.businessName ?? ''}'.trim()),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() => _errorMessage = result.errorMessage);
    }
  }

  Future<void> _onDeactivate() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Desactivar Premium'),
        content: const Text(
          'Volverán a mostrarse anuncios. Podrás reactivar con tu código cuando quieras.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Desactivar'),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;

    await context.read<PremiumProvider>().deactivate();
    if (!mounted) return;
    context.read<AdProvider>().setPremium(false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final premium = context.watch<PremiumProvider>();

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Premium',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: premium.isPremium
            ? _buildActiveState(context, isDark, premium)
            : _buildInactiveState(context, isDark, premium),
      ),
    );
  }

  Widget _buildActiveState(
    BuildContext context,
    bool isDark,
    PremiumProvider premium,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Icon(Icons.verified_rounded,
                  color: Colors.green, size: 56),
              const SizedBox(height: 12),
              Text(
                'Premium activo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                ),
              ),
              if (premium.businessName != null) ...[
                const SizedBox(height: 6),
                Text(
                  premium.businessName!,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Text(
                'Sin anuncios mientras tu negocio esté activo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white54 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: _onDeactivate,
          child: const Text(
            'Desactivar en este dispositivo',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildInactiveState(
    BuildContext context,
    bool isDark,
    PremiumProvider premium,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Activar Premium',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ingresa el código proporcionado por tu negocio para quitar los anuncios.',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9\-_]')),
                  LengthLimitingTextInputFormatter(32),
                ],
                decoration: InputDecoration(
                  labelText: 'Código',
                  hintText: 'EJ: LOPEZ2026',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorText: _errorMessage,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: premium.isActivating ? null : _onActivate,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: premium.isActivating
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Activar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
