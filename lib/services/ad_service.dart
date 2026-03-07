// lib/services/ad_service.dart

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class AdService {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;

  bool get isAdLoaded => _isAdLoaded;

  // 🎯 IDs REALES DE TU ADMOB
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4091749681327331/7065488875';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4091749681327331/9351281995';
    }
    throw UnsupportedError('Plataforma no soportada');
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4091749681327331/9351281995';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // Test ID iOS
    }
    throw UnsupportedError('Plataforma no soportada');
  }

  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    // 🎯 Pre-cargar el primer anuncio
    await loadRewardedAd();
  }

  Future<void> loadRewardedAd() async {
    // 🎯 No cargar si ya hay uno cargado
    if (_isAdLoaded && _rewardedAd != null) {
      debugPrint('⚠️ Ya hay un Rewarded Ad cargado');
      return;
    }

    debugPrint('🔄 Intentando cargar Rewarded Ad...');

    await RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isAdLoaded = true;
          debugPrint('✅ Rewarded Ad cargado correctamente');
        },
        onAdFailedToLoad: (error) {
          _isAdLoaded = false;
          _rewardedAd = null;
          debugPrint(
            '❌ Error cargando Rewarded Ad: ${error.code} - ${error.message}',
          );
        },
      ),
    );
  }

  Future<bool> showRewardedAd({
    required VoidCallback onRewardEarned,
    required VoidCallback onAdDismissed,
  }) async {
    if (_rewardedAd == null || !_isAdLoaded) {
      debugPrint('❌ No hay anuncio cargado para mostrar');
      // 🎯 Intentar cargar uno nuevo
      await loadRewardedAd();
      return false;
    }

    debugPrint('▶️ Mostrando Rewarded Ad...');

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        debugPrint('📺 Anuncio mostrado en pantalla completa');
      },
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('❌ Usuario cerró el anuncio');
        ad.dispose();
        _rewardedAd = null;
        _isAdLoaded = false;
        onAdDismissed();
        // 🎯 Pre-cargar el siguiente
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint(
          '❌ Error mostrando anuncio: ${error.code} - ${error.message}',
        );
        ad.dispose();
        _rewardedAd = null;
        _isAdLoaded = false;
        onAdDismissed();
        // 🎯 Pre-cargar el siguiente
        loadRewardedAd();
      },
    );

    await _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint('🎁 ¡Recompensa ganada! ${reward.amount} ${reward.type}');
        onRewardEarned();
      },
    );

    return true;
  }

  /// Cargar Banner Ad
  BannerAd createBannerAd({
    required VoidCallback onAdLoaded,
    required Function(LoadAdError) onAdFailedToLoad,
  }) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner, // 🎯 Cambiado a banner normal (320x50)
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('✅ Banner Ad cargado');
          onAdLoaded();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('❌ Banner Ad falló: ${error.code} - ${error.message}');
          ad.dispose();
          onAdFailedToLoad(error);
        },
      ),
    )..load();
  }

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isAdLoaded = false;
  }
}
