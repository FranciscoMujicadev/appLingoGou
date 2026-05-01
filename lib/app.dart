// lib/app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/providers/auth_provider.dart';
import 'providers/ad_provider.dart';
import 'providers/guide_tour_provider.dart';
import 'providers/premium_provider.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';

class EnglishLearningApp extends StatelessWidget {
  const EnglishLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PremiumProvider()),
        ChangeNotifierProxyProvider<PremiumProvider, AdProvider>(
          create: (_) => AdProvider(),
          update: (_, premium, ad) {
            ad ??= AdProvider();
            ad.setPremium(premium.isPremium);
            return ad;
          },
        ),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => GuideTourProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'English Learning',
            theme: AppTheme.lightThemeWith(primary: themeProvider.primaryColor),
            darkTheme: AppTheme.darkThemeWith(primary: themeProvider.primaryColor),
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
