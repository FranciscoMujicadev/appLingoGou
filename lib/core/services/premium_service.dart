// lib/core/services/premium_service.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivationResult {
  final bool success;
  final String? errorMessage;
  final String? businessId;
  final String? businessName;

  const ActivationResult.ok({this.businessId, this.businessName})
      : success = true,
        errorMessage = null;

  const ActivationResult.error(String message)
      : success = false,
        errorMessage = message,
        businessId = null,
        businessName = null;
}

class PremiumService {
  static const _kPremiumFlagKey = 'premium_active';
  static const _kBusinessIdKey = 'premium_business_id';
  static const _kBusinessNameKey = 'premium_business_name';
  static const _kActivationIdKey = 'premium_activation_id';
  static const _kLastCheckKey = 'premium_last_check_ms';
  static const _kDeviceIdKey = 'premium_device_id';

  static const Duration revalidationInterval = Duration(days: 7);
  static const Duration graceOfflineWindow = Duration(days: 14);
  static const int _maxActivationsPerBusiness = 50;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_kDeviceIdKey);
    if (cached != null && cached.isNotEmpty) return cached;

    String id;
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        id = info.id;
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        id = info.identifierForVendor ?? 'ios-unknown';
      } else {
        id = 'unsupported-${DateTime.now().millisecondsSinceEpoch}';
      }
    } catch (e) {
      id = 'fallback-${DateTime.now().millisecondsSinceEpoch}';
    }

    await prefs.setString(_kDeviceIdKey, id);
    return id;
  }

  Future<bool> isPremiumLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kPremiumFlagKey) ?? false;
  }

  Future<String?> getBusinessName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kBusinessNameKey);
  }

  Future<ActivationResult> activateWithCode(String rawCode) async {
    final code = rawCode.trim().toUpperCase();
    if (code.isEmpty) {
      return const ActivationResult.error('Ingresa un código.');
    }

    try {
      final query = await _firestore
          .collection('businesses')
          .where('code', isEqualTo: code)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        return const ActivationResult.error('Código inválido.');
      }

      final doc = query.docs.first;
      final data = doc.data();
      final businessId = doc.id;
      final active = data['active'] == true;
      final businessName = (data['name'] as String?) ?? 'Negocio';
      final maxActivations =
          (data['maxActivations'] as num?)?.toInt() ?? _maxActivationsPerBusiness;

      if (!active) {
        return const ActivationResult.error(
          'Este código está desactivado. Contacta al negocio.',
        );
      }

      final deviceId = await getDeviceId();

      final existing = await _firestore
          .collection('activations')
          .where('businessId', isEqualTo: businessId)
          .where('deviceId', isEqualTo: deviceId)
          .limit(1)
          .get();

      String activationId;
      if (existing.docs.isNotEmpty) {
        activationId = existing.docs.first.id;
        await existing.docs.first.reference.update({
          'lastCheckAt': FieldValue.serverTimestamp(),
        });
      } else {
        final countSnap = await _firestore
            .collection('activations')
            .where('businessId', isEqualTo: businessId)
            .count()
            .get();
        final currentCount = countSnap.count ?? 0;
        if (currentCount >= maxActivations) {
          return const ActivationResult.error(
            'Cupo lleno. Contacta al negocio para liberar un espacio.',
          );
        }

        final newDoc = await _firestore.collection('activations').add({
          'businessId': businessId,
          'deviceId': deviceId,
          'activatedAt': FieldValue.serverTimestamp(),
          'lastCheckAt': FieldValue.serverTimestamp(),
        });
        activationId = newDoc.id;
      }

      await _saveLocal(
        businessId: businessId,
        businessName: businessName,
        activationId: activationId,
      );

      return ActivationResult.ok(
        businessId: businessId,
        businessName: businessName,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('❌ Error activando premium: $e');
      return const ActivationResult.error(
        'No se pudo validar. Revisa tu conexión e intenta de nuevo.',
      );
    }
  }

  Future<bool> revalidateIfDue() async {
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool(_kPremiumFlagKey) ?? false)) return false;

    final lastCheckMs = prefs.getInt(_kLastCheckKey) ?? 0;
    final lastCheck = DateTime.fromMillisecondsSinceEpoch(lastCheckMs);
    final now = DateTime.now();

    if (now.difference(lastCheck) < revalidationInterval) {
      return true;
    }

    final businessId = prefs.getString(_kBusinessIdKey);
    final activationId = prefs.getString(_kActivationIdKey);
    if (businessId == null || activationId == null) {
      await _clearLocal();
      return false;
    }

    try {
      final businessDoc =
          await _firestore.collection('businesses').doc(businessId).get();
      final active = businessDoc.data()?['active'] == true;

      if (!active) {
        await _clearLocal();
        return false;
      }

      await _firestore.collection('activations').doc(activationId).update({
        'lastCheckAt': FieldValue.serverTimestamp(),
      });
      await prefs.setInt(_kLastCheckKey, now.millisecondsSinceEpoch);
      return true;
    } catch (e) {
      if (kDebugMode) debugPrint('⚠️ Revalidación sin internet: $e');
      if (now.difference(lastCheck) > graceOfflineWindow) {
        await _clearLocal();
        return false;
      }
      return true;
    }
  }

  Future<void> deactivate() async {
    await _clearLocal();
  }

  Future<void> _saveLocal({
    required String businessId,
    required String businessName,
    required String activationId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kPremiumFlagKey, true);
    await prefs.setString(_kBusinessIdKey, businessId);
    await prefs.setString(_kBusinessNameKey, businessName);
    await prefs.setString(_kActivationIdKey, activationId);
    await prefs.setInt(
      _kLastCheckKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<void> _clearLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kPremiumFlagKey);
    await prefs.remove(_kBusinessIdKey);
    await prefs.remove(_kBusinessNameKey);
    await prefs.remove(_kActivationIdKey);
    await prefs.remove(_kLastCheckKey);
  }
}
