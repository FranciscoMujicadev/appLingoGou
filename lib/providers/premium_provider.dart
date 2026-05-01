// lib/providers/premium_provider.dart

import 'package:flutter/foundation.dart';
import '../core/services/premium_service.dart';

class PremiumProvider with ChangeNotifier {
  final PremiumService _service = PremiumService();

  bool _isPremium = false;
  String? _businessName;
  bool _isActivating = false;

  bool get isPremium => _isPremium;
  String? get businessName => _businessName;
  bool get isActivating => _isActivating;

  PremiumProvider() {
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    _isPremium = await _service.isPremiumLocal();
    _businessName = await _service.getBusinessName();
    if (_isPremium) notifyListeners();

    final stillValid = await _service.revalidateIfDue();
    if (stillValid != _isPremium) {
      _isPremium = stillValid;
      if (!stillValid) _businessName = null;
      notifyListeners();
    }
  }

  Future<ActivationResult> activate(String code) async {
    _isActivating = true;
    notifyListeners();

    final result = await _service.activateWithCode(code);
    if (result.success) {
      _isPremium = true;
      _businessName = result.businessName;
    }

    _isActivating = false;
    notifyListeners();
    return result;
  }

  Future<void> deactivate() async {
    await _service.deactivate();
    _isPremium = false;
    _businessName = null;
    notifyListeners();
  }
}
