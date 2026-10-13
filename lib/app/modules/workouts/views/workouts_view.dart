import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/primary_button.dart';

class WorkoutsView extends StatelessWidget {
  const WorkoutsView({super.key});

  @override
  Widget build(BuildContext context) {
    final RxBool isWorkoutActive = false.obs;

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
                  'Gym & Workouts',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Track your exercise sessions and weekly gym goals.',
                  style: TextStyle(fontSize: 12, color: AppColors.textSubTitle),
                ),
                const SizedBox(height: 20),

                // Weekly Gym Progress
                CustomCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Weekly Gym Goal',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textWhite,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '2 of 4 sessions completed',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSubTitle,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.gymTeal.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.gymTeal),
                        ),
                        child: const Text(
                          '2 / 4',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gymTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Quick Workout Start Card
                Obx(() {
                  final active = isWorkoutActive.value;
                  return CustomCard(
                    backgroundColor: AppColors.modalBackground,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryNeon,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                active ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                color: AppColors.textDark,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    active ? 'Workout Session In Progress' : 'Start Gym Tracker',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textWhite,
                                    ),
                                  ),
                                  Text(
                                    active ? 'Duration: 24:15 min' : 'Tap to start live calorie & heart rate log',
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
                        const SizedBox(height: 16),
                        PrimaryButton(
                          text: active ? 'Finish Workout' : 'Start Session Now',
                          backgroundColor: active ? AppColors.alertRed : AppColors.primaryNeon,
                          textColor: active ? AppColors.textWhite : AppColors.textDark,
                          onTap: () => isWorkoutActive.value = !isWorkoutActive.value,
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 24),

                // Activity Categories Grid
                const Text(
                  'Select Activity',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  children: [
                    _buildActivityTile('Running', '320 kcal avg', Icons.directions_run_rounded, AppColors.primaryNeon),
                    _buildActivityTile('Cycling', '450 kcal avg', Icons.directions_bike_rounded, AppColors.gymTeal),
                    _buildActivityTile('Gym Weights', '280 kcal avg', Icons.fitness_center_rounded, AppColors.alertRed),
                    _buildActivityTile('Yoga & Stretch', '180 kcal avg', Icons.self_improvement_rounded, AppColors.proteinPurple),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityTile(String title, String subtitle, IconData icon, Color color) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textWhite),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 11, color: AppColors.textSubTitle),
          ),
        ],
      ),
    );
  }
}
