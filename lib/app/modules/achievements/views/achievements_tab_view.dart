import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/services/user_preferences_service.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/achievements_controller.dart';

class AchievementsTabView extends StatelessWidget {
  const AchievementsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final prefService = Get.find<UserPreferencesService>();
    final controller = Get.put(AchievementsController());

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
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${prefService.userName.value}\'s Achievements',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textWhite,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Celebrate your milestones and keep your streak going!',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSubTitle,
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),

                // Streak Banner Card
                CustomCard(
                  backgroundColor: AppColors.modalBackground,
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.sleepYellow.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_fire_department_rounded,
                          color: AppColors.sleepYellow,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '7 Day Active Streak! 🔥',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textWhite,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'You are in the top 5% of step achievers this week.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSubTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Celebration Button
                PrimaryButton(
                  text: 'View Goal Celebration Modal',
                  icon: const Icon(Icons.stars_rounded, color: AppColors.textDark),
                  onTap: () => controller.dismissDialog(),
                ),
                const SizedBox(height: 24),

                // Badges List
                const Text(
                  'Unlocked Badges',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 12),

                _buildBadgeCard(
                  title: '10,000 Step Master',
                  description: 'Reached daily step goal for 5 consecutive days.',
                  icon: Icons.directions_walk_rounded,
                  color: AppColors.primaryNeon,
                  isUnlocked: true,
                ),
                const SizedBox(height: 12),
                _buildBadgeCard(
                  title: 'Sleep Champion',
                  description: 'Logged 7.5+ hours of sleep 3 nights in a row.',
                  icon: Icons.nightlight_round,
                  color: AppColors.sleepYellow,
                  isUnlocked: true,
                ),
                const SizedBox(height: 12),
                _buildBadgeCard(
                  title: 'Gym Warrior',
                  description: 'Completed 4 weekly gym sessions.',
                  icon: Icons.directions_bike_rounded,
                  color: AppColors.gymTeal,
                  isUnlocked: false,
                ),
                const SizedBox(height: 12),
                _buildBadgeCard(
                  title: 'Protein Target Met',
                  description: 'Reached 300g daily protein goal.',
                  icon: Icons.egg_alt_rounded,
                  color: AppColors.proteinPurple,
                  isUnlocked: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isUnlocked,
  }) {
    return CustomCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isUnlocked ? color.withValues(alpha: 0.15) : AppColors.cardBorder,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isUnlocked ? color : AppColors.textMuted,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isUnlocked ? AppColors.textWhite : AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 6),
                    if (isUnlocked)
                      const Icon(Icons.check_circle_rounded, size: 14, color: AppColors.primaryNeon),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSubTitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
