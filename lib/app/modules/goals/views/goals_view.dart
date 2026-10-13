import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/services/user_preferences_service.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/primary_button.dart';

class GoalsView extends StatelessWidget {
  const GoalsView({super.key});

  @override
  Widget build(BuildContext context) {
    final prefService = Get.find<UserPreferencesService>();

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
                // Header
                const Text(
                  'Daily Goals & Targets',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Customize targets to match your personal fitness journey.',
                  style: TextStyle(fontSize: 12, color: AppColors.textSubTitle),
                ),
                const SizedBox(height: 24),

                // Step Goal Card
                CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.directions_walk_rounded, color: AppColors.primaryNeon, size: 20),
                              SizedBox(width: 8),
                              Text('Daily Step Goal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textWhite)),
                            ],
                          ),
                          Obx(() => Text(
                                '${prefService.dailyStepGoal.value} steps',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryNeon),
                              )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        return Slider(
                          value: prefService.dailyStepGoal.value.toDouble(),
                          min: 3000,
                          max: 20000,
                          divisions: 34,
                          activeColor: AppColors.primaryNeon,
                          inactiveColor: AppColors.cardBorder,
                          onChanged: (val) => prefService.updateStepGoal(val.toInt()),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Sleep Target Card
                CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.nightlight_round, color: AppColors.sleepYellow, size: 20),
                              SizedBox(width: 8),
                              Text('Sleep Target', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textWhite)),
                            ],
                          ),
                          Obx(() => Text(
                                '${prefService.dailySleepGoal.value.toStringAsFixed(1)} hrs',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.sleepYellow),
                              )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        return Slider(
                          value: prefService.dailySleepGoal.value,
                          min: 5.0,
                          max: 12.0,
                          divisions: 14,
                          activeColor: AppColors.sleepYellow,
                          inactiveColor: AppColors.cardBorder,
                          onChanged: (val) => prefService.updateSleepGoal(val),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Protein Goal Card
                CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.egg_alt_rounded, color: AppColors.proteinPurple, size: 20),
                              SizedBox(width: 8),
                              Text('Protein Goal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textWhite)),
                            ],
                          ),
                          Obx(() => Text(
                                '${prefService.dailyProteinGoal.value} g',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.proteinPurple),
                              )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        return Slider(
                          value: prefService.dailyProteinGoal.value.toDouble(),
                          min: 50,
                          max: 400,
                          divisions: 35,
                          activeColor: AppColors.proteinPurple,
                          inactiveColor: AppColors.cardBorder,
                          onChanged: (val) => prefService.updateProteinGoal(val.toInt()),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Save Confirmation Button
                PrimaryButton(
                  text: 'Save Goal Changes',
                  onTap: () {
                    Get.snackbar(
                      'Goals Saved',
                      'Your target preferences have been updated!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.cardBackground,
                      colorText: AppColors.primaryNeon,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
