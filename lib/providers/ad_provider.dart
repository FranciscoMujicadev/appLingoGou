// lib/providers/ad_provider.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_service.dart';

class AdProvider with ChangeNotifier {
  final AdService _adService = AdService();

  int _cardsViewedCount = 0;
  bool _isLoadingAd = false;

  // Para Banner Ads
  final Map<int, BannerAd?> _bannerAds = {};
  final Set<int> _loadedAdIndices = {};

  int get cardsViewedCount => _cardsViewedCount;
  bool get shouldShowAd => _cardsViewedCount >= 13;
  bool get isLoadingAd => _isLoadingAd;

  // Obtener Banner Ad por índice
  BannerAd? getBannerAd(int index) => _bannerAds[index];
  bool isBannerAdLoaded(int index) => _loadedAdIndices.contains(index);

  AdProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _adService.initialize();
    await _adService.loadRewardedAd();
    notifyListeners();
  }

  void incrementCardView() {
    _cardsViewedCount++;
    // Solo notificar cuando cambia shouldShowAd (al cruzar el umbral de 13)
    if (_cardsViewedCount == 13) {
      notifyListeners();
    }
  }

  Future<bool> showRewardedAd(BuildContext context) async {
    if (_isLoadingAd) return false;

    _isLoadingAd = true;
    notifyListeners();

    if (!_adService.isAdLoaded) {
      await _adService.loadRewardedAd();
      await Future.delayed(const Duration(seconds: 2));
    }

    final success = await _adService.showRewardedAd(
      onRewardEarned: () {
        _cardsViewedCount = 0;
        _isLoadingAd = false;
        if (kDebugMode) debugPrint('✅ Anuncio visto, contador reseteado');
        notifyListeners();
      },
      onAdDismissed: () {
        _isLoadingAd = false;
        notifyListeners();
      },
    );

    if (!success) {
      _isLoadingAd = false;
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo cargar el anuncio. Intenta más tarde.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }

    return success;
  }

  /// Cargar Banner Ad para un índice específico
  void loadBannerAd(int index) {
    if (_loadedAdIndices.contains(index)) return;

    try {
      final bannerAd = _adService.createBannerAd(
        onAdLoaded: () {
          _loadedAdIndices.add(index);
          notifyListeners();
          if (kDebugMode) debugPrint('✅ Banner Ad cargado para índice $index');
        },
        onAdFailedToLoad: (error) {
          if (kDebugMode) debugPrint('❌ Error cargando Banner Ad para índice $index: $error');
          _bannerAds.remove(index);
          notifyListeners();
        },
      );

      _bannerAds[index] = bannerAd;
    } catch (e) {
      if (kDebugMode) debugPrint('❌ Excepción al cargar Banner Ad: $e');
    }
  }

  /// Liberar Banner Ad
  void disposeBannerAd(int index) {
    final ad = _bannerAds[index];
    if (ad != null) {
      ad.dispose();
      _bannerAds.remove(index);
      _loadedAdIndices.remove(index);
      if (kDebugMode) debugPrint('🗑️ Banner Ad liberado para índice $index');
    }
  }

  @override
  void dispose() {
    for (var ad in _bannerAds.values) {
      ad?.dispose();
    }
    _bannerAds.clear();
    _loadedAdIndices.clear();

    _adService.dispose();
    super.dispose();
  }
}
