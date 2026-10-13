import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/shimmer_card_loader.dart';
import '../controllers/home_controller.dart';
import '../widgets/calories_card.dart';
import '../widgets/days_header.dart';
import '../widgets/gym_card.dart';
import '../widgets/protein_card.dart';
import '../widgets/readiness_card.dart';
import '../widgets/sleep_card.dart';
import '../widgets/steps_card.dart';
import '../widgets/weight_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: 100, // Space for floating nav bar
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top App Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppStrings.homeTitle,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textWhite,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Obx(() {
                          final name = controller.prefService.userName.value;
                          return Text(
                            '$name you can easily track your progress',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSubTitle,
                            ),
                          );
                        }),
                      ],
                    ),
                    // Avatar profile button -> Navigates to Settings tab
                    GestureDetector(
                      onTap: () => controller.openSettingsTab(),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.cardBackground,
                          border: Border.all(
                            color: AppColors.primaryNeon,
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person_rounded,
                            color: AppColors.primaryNeon,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Step Tracker Status Banner
                Obx(() {
                  final status = controller.trackingService.statusMessage.value;
                  final isTracking = controller.trackingService.isTracking.value;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isTracking
                          ? AppColors.cardBackground
                          : AppColors.alertRed.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isTracking
                            ? AppColors.cardBorder
                            : AppColors.alertRed.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isTracking
                              ? Icons.sensors_rounded
                              : Icons.sensors_off_rounded,
                          size: 16,
                          color: isTracking
                              ? AppColors.primaryNeon
                              : AppColors.alertRed,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 11,
                              color: isTracking
                                  ? AppColors.textSubTitle
                                  : AppColors.textWhite,
                            ),
                          ),
                        ),
                        if (!isTracking)
                          TextButton(
                            onPressed: () => controller.startStepTracking(),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 24),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Enable',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryNeon,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),

                // Days Week Row
                const DaysHeader(),
                const SizedBox(height: 20),

                // Fitness Grid Dashboard with Shimmer Effect
                Obx(() {
                  if (controller.isLoading.value) {
                    return const DashboardShimmerLoader();
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column
                      Expanded(
                        child: Column(
                          children: const [
                            ReadinessCard(),
                            SizedBox(height: 14),
                            StepsCard(),
                            SizedBox(height: 14),
                            CaloriesCard(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Right Column
                      Expanded(
                        child: Column(
                          children: const [
                            SleepCard(),
                            SizedBox(height: 14),
                            GymCard(),
                            SizedBox(height: 14),
                            ProteinCard(),
                            SizedBox(height: 14),
                            WeightCard(),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
