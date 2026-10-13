import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/circular_progress_ring.dart';
import '../../../widgets/custom_card.dart';
import '../controllers/home_controller.dart';

class StepsCard extends GetView<HomeController> {
  const StepsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () => controller.openStepsDetail(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                AppStrings.steps,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              Icon(
                Icons.directions_walk_rounded,
                size: 18,
                color: AppColors.primaryNeon,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Obx(() {
              final double progress =
                  controller.stepsCurrent.value / controller.stepsTarget.value;

              final String formattedCurrent = controller.stepsCurrent.value
                  .toString()
                  .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
              final String formattedTarget = controller.stepsTarget.value
                  .toString()
                  .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

              return CircularProgressRing(
                progress: progress,
                size: 110,
                strokeWidth: 8,
                progressColor: AppColors.primaryNeon,
                centerChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formattedCurrent,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textWhite,
                      ),
                    ),
                    Text(
                      '/$formattedTarget Steps',
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.textSubTitle,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
