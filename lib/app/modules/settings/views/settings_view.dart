import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/services/step_tracking_service.dart';
import '../../../data/services/user_preferences_service.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_card.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final prefService = Get.find<UserPreferencesService>();
    final trackingService = Get.find<StepTrackingService>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundGradientStart,
              AppColors.backgroundGradientEnd,
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'Settings & Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Manage account preferences and app configuration.',
                  style: TextStyle(fontSize: 12, color: AppColors.textSubTitle),
                ),
                const SizedBox(height: 20),

                // User Profile Header Card
                Obx(() {
                  return CustomCard(
                    backgroundColor: AppColors.modalBackground,
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cardBackground,
                            border: Border.all(color: AppColors.primaryNeon, width: 2),
                          ),
                          child: const Center(
                            child: Icon(Icons.person_rounded, color: AppColors.primaryNeon, size: 32),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prefService.userName.value,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textWhite,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Step Goal: ${prefService.dailyStepGoal.value} • Weight: ${prefService.targetWeight.value.toStringAsFixed(1)} kg',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSubTitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 24),

                // Hardware Sensor Control
                const Text(
                  'Step Tracking Sensor',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textWhite),
                ),
                const SizedBox(height: 10),
                CustomCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.sensors_rounded, color: AppColors.primaryNeon, size: 20),
                          SizedBox(width: 12),
                          Text('Live Motion Sensor', style: TextStyle(fontSize: 14, color: AppColors.textWhite)),
                        ],
                      ),
                      Obx(() {
                        final isTracking = trackingService.isTracking.value;
                        return Switch(
                          value: isTracking,
                          activeTrackColor: AppColors.primaryNeon,
                          onChanged: (val) {
                            if (val) {
                              trackingService.startTracking();
                            } else {
                              trackingService.stopTracking();
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // General Preferences
                const Text(
                  'Preferences & Reset',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textWhite),
                ),
                const SizedBox(height: 10),
                CustomCard(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.refresh_rounded, color: AppColors.alertRed),
                        title: const Text('Reset Onboarding & User Data', style: TextStyle(color: AppColors.alertRed, fontSize: 14, fontWeight: FontWeight.bold)),
                        subtitle: const Text('Show onboarding flow again on next app start', style: TextStyle(color: AppColors.textSubTitle, fontSize: 11)),
                        onTap: () async {
                          await prefService.resetOnboarding();
                          Get.snackbar('Reset Complete', 'Onboarding will show on restart', snackPosition: SnackPosition.BOTTOM);
                          Get.offAllNamed(AppRoutes.ONBOARDING);
                        },
                      ),
                      const Divider(color: AppColors.cardBorder, height: 1),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.info_outline_rounded, color: AppColors.textWhite),
                        title: const Text('App Version', style: TextStyle(color: AppColors.textWhite, fontSize: 14)),
                        trailing: const Text('v1.0.0 (Build 1)', style: TextStyle(color: AppColors.textSubTitle, fontSize: 12)),
                      ),
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
}
