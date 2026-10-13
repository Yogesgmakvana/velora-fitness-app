import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/step_tracking_service.dart';
import '../../../data/services/user_preferences_service.dart';
import '../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  final nameTextController = TextEditingController(text: 'Sofia');
  final selectedStepGoal = 10000.obs;
  final selectedWeight = 65.0.obs;

  final isPermissionGranted = false.obs;

  final stepGoalsList = [5000, 8000, 10000, 12000, 15000];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finishOnboarding();
    }
  }

  Future<void> requestActivityPermission() async {
    final trackingService = Get.find<StepTrackingService>();
    final granted = await trackingService.requestPermission();
    isPermissionGranted.value = granted;
  }

  Future<void> finishOnboarding() async {
    final prefService = Get.find<UserPreferencesService>();

    final String name = nameTextController.text.trim();
    await prefService.saveUserData(
      name: name.isNotEmpty ? name : 'Sofia',
      stepGoal: selectedStepGoal.value,
      weight: selectedWeight.value,
    );

    Get.offAllNamed(AppRoutes.MAIN_NAVIGATION);
  }

  @override
  void onClose() {
    nameTextController.dispose();
    pageController.dispose();
    super.onClose();
  }
}
