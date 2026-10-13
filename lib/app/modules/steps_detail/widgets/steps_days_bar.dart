import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/steps_detail_controller.dart';

class StepsDaysBar extends GetView<StepsDetailController> {
  const StepsDaysBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(controller.daysList.length, (index) {
          final day = controller.daysList[index];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                day.initial,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: day.isCompleted ? AppColors.primaryNeon : AppColors.cardBackground,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: day.isCompleted ? AppColors.primaryNeon : AppColors.cardBorder,
                    width: 1.5,
                  ),
                  boxShadow: day.isCompleted
                      ? [
                          BoxShadow(
                            color: AppColors.primaryNeon.withValues(alpha: 0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: day.isCompleted
                      ? const Icon(
                          Icons.check_rounded,
                          size: 20,
                          color: AppColors.textDark,
                        )
                      : null,
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
