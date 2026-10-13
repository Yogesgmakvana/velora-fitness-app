import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_card.dart';
import '../controllers/home_controller.dart';

class GymCard extends GetView<HomeController> {
  const GymCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () => controller.incrementGymSession(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                AppStrings.gym,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              Icon(
                Icons.directions_bike_rounded,
                size: 18,
                color: AppColors.gymTeal,
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            AppStrings.thisWeek,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSubTitle,
            ),
          ),
          const SizedBox(height: 4),
          Obx(() {
            return Text(
              '${controller.gymCompleted.value}/${controller.gymTotal.value}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
              ),
            );
          }),
        ],
      ),
    );
  }
}
