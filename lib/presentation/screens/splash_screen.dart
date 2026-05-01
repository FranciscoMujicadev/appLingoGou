// lib/presentation/screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/connectivity_service.dart';
import '../../core/utils/onboarding_storage.dart';
import 'main_navigation_screen.dart';
import 'onboarding_screen.dart';

class SplashDecisionScreen extends StatefulWidget {
  const SplashDecisionScreen({super.key});

  @override
  State<SplashDecisionScreen> createState() => _SplashDecisionScreenState();
}

class _SplashDecisionScreenState extends State<SplashDecisionScreen> {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isCheckingConnection = true;
  bool _hasInternet = false;

  @override
  void initState() {
    super.initState();
    _checkConnectionAndProceed();
  }

  Future<void> _checkConnectionAndProceed() async {
    final hasConnection = await _connectivityService.hasInternetConnection();

    setState(() {
      _hasInternet = hasConnection;
      _isCheckingConnection = false;
    });

    if (hasConnection) {
      await _navigateToApp();
    }
  }

  Future<void> _navigateToApp() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final hasSeenOnboarding = await OnboardingStorage.hasSeenOnboarding();

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => hasSeenOnboarding
              ? const MainNavigationScreen()
              : const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingConnection) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 20),
              Text(
                'Verificando conexión...',
                style: TextStyle(
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: Colors.white,
                  fontSize: 15.5,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (!_hasInternet) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 100, color: Colors.red.shade400),
                  const SizedBox(height: 32),
                  Text(
                    '¡Sin conexión a Internet!',
                    style: TextStyle(
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      color: Colors.white,
                      fontSize: 23.5,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'LingoGou requiere conexión a internet para funcionar correctamente.',
                    style: TextStyle(
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      color: Colors.grey.shade400,
                      fontSize: 15.5,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isCheckingConnection = true;
                        });
                        _checkConnectionAndProceed();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.refresh, color: Colors.white, size: 24),
                      label: Text(
                        'Reintentar',
                        style: TextStyle(
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade800, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline,
                                color: const Color(0xFF9C95FF), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Verifica:',
                              style: TextStyle(
                                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                color: Colors.white,
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildCheckItem('WiFi o datos móviles activados'),
                        _buildCheckItem('Modo avión desactivado'),
                        _buildCheckItem('Señal de internet estable'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline,
              color: Colors.green.shade400, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                color: Colors.grey.shade400,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
