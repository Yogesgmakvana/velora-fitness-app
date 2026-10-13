import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/semi_circular_gauge.dart';
import '../controllers/home_controller.dart';

class CaloriesCard extends GetView<HomeController> {
  const CaloriesCard({super.key});

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
                AppStrings.calories,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              Icon(
                Icons.eco_rounded,
                size: 18,
                color: AppColors.caloriesPurple,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Obx(() {
              return SemiCircularGauge(
                progress: 0.65,
                size: 95,
                strokeWidth: 8,
                activeColor: AppColors.caloriesPurple,
                centerChild: Text(
                  '${controller.caloriesCurrent.value}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
