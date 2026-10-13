import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/line_chart_painter.dart';
import '../controllers/home_controller.dart';

class ReadinessCard extends GetView<HomeController> {
  const ReadinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                AppStrings.readiness,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              Icon(
                Icons.fitness_center_rounded,
                size: 18,
                color: AppColors.alertRed,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const LineChartWidget(height: 38),
          const SizedBox(height: 12),
          Obx(() {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${controller.readinessScore.value}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNeon,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  AppStrings.readinessGoal,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSubTitle,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
