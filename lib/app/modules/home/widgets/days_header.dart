import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/home_controller.dart';

class DaysHeader extends GetView<HomeController> {
  const DaysHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(controller.weekDays.length, (index) {
          final day = controller.weekDays[index];
          final isSelected = day.isSelected;
          final borderRingColor = day.ringColor ?? AppColors.cardBorder;

          return GestureDetector(
            onTap: () => controller.selectDay(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  day.initial,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.textWhite : AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryNeon : AppColors.cardBackground,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primaryNeon : borderRingColor,
                      width: isSelected ? 2.0 : 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primaryNeon.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      '${day.dateNumber}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? AppColors.textDark : AppColors.textWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}
