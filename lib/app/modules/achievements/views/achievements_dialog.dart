import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/circular_progress_ring.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/achievements_controller.dart';

class AchievementsDialog extends StatelessWidget {
  const AchievementsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AchievementsController());

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: AppColors.modalBackground,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: AppColors.cardBorder,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Festive Progress Ring
            CircularProgressRing(
              progress: 1.0,
              size: 150,
              strokeWidth: 10,
              progressColor: AppColors.primaryNeon,
              showOuterRays: true,
              centerChild: Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.directions_walk_rounded,
                      color: AppColors.primaryNeon,
                      size: 28,
                    ),
                    SizedBox(height: 6),
                    Text(
                      AppStrings.achievementStepsValue,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textWhite,
                      ),
                    ),
                    Text(
                      AppStrings.achievementStepsLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSubTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Achievements Title & Subtitle
            const Text(
              AppStrings.achievementsTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              AppStrings.userSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSubTitle,
              ),
            ),
            const SizedBox(height: 28),

            // Vibrant Hooray Button
            PrimaryButton(
              text: AppStrings.hooray,
              onTap: () => controller.dismissDialog(),
            ),
          ],
        ),
      ),
    );
  }
}
