import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../data/services/user_preferences_service.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  Timer? _splashTimer;

  @override
  void onInit() {
    super.onInit();
    _startSplashTimer();
  }

  void _startSplashTimer() {
    debugPrint("VELORA Splash: Starting 2.0s splash timer...");
    _splashTimer = Timer(const Duration(milliseconds: 2000), () {
      _navigateToNext();
    });
  }

  void _navigateToNext() {
    try {
      final UserPreferencesService prefService = Get.isRegistered<UserPreferencesService>()
          ? Get.find<UserPreferencesService>()
          : Get.put(UserPreferencesService());

      final isFirstTime = prefService.isFirstTime.value;
      debugPrint("VELORA Splash: Navigation triggered. isFirstTime = $isFirstTime");

      if (isFirstTime) {
        Get.offAllNamed(AppRoutes.ONBOARDING);
      } else {
        Get.offAllNamed(AppRoutes.MAIN_NAVIGATION);
      }
    } catch (e) {
      debugPrint("VELORA Splash Navigation Error: $e");
      Get.offAllNamed(AppRoutes.ONBOARDING);
    }
  }

  @override
  void onClose() {
    _splashTimer?.cancel();
    super.onClose();
  }
}
