// lib/main.dart

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'core/injection_container.dart' as di;
import 'core/utils/onboarding_storage.dart';
import 'core/utils/connectivity_service.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/main_navigation_screen.dart';
import 'providers/ad_provider.dart';
import 'providers/guide_tour_provider.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Mobile Ads
  await MobileAds.instance.initialize();

  // Inicializar inyección de dependencias
  await di.init();

  runApp(const EnglishLearningApp());
}

class EnglishLearningApp extends StatelessWidget {
  const EnglishLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AdProvider()),
        ChangeNotifierProvider(create: (_) => GuideTourProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'English Learning',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashDecisionScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

// Pantalla que decide si mostrar onboarding o ir directo a la app
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
    // Verificar conexión a internet
    final hasConnection = await _connectivityService.hasInternetConnection();

    setState(() {
      _hasInternet = hasConnection;
      _isCheckingConnection = false;
    });

    if (hasConnection) {
      // Si hay internet, continuar normalmente
      await _navigateToApp();
    }
    // Si no hay internet, se queda en la pantalla mostrando el error
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
      // Mostrando splash mientras verifica
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Verificando conexión...',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (!_hasInternet) {
      // No hay internet - mostrar pantalla de error
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ícono de sin internet
                  Icon(Icons.wifi_off, size: 100, color: Colors.red.shade400),
                  const SizedBox(height: 32),

                  // Título
                  const Text(
                    '¡Sin conexión a Internet!',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Mensaje
                  Text(
                    'LingoGou requiere conexión a internet para funcionar correctamente.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Botón de reintentar
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
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 24,
                      ),
                      label: const Text(
                        'Reintentar',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Instrucciones
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
                            Icon(
                              Icons.info_outline,
                              color: Colors.blue.shade300,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Verifica:',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                                fontSize: 14,
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

    // Este caso no debería ocurrir, pero por seguridad
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
          Icon(
            Icons.check_circle_outline,
            color: Colors.green.shade400,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.grey.shade400,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
