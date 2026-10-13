import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/semi_circular_gauge.dart';
import '../controllers/home_controller.dart';

class ProteinCard extends GetView<HomeController> {
  const ProteinCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () => _showProteinLogSheet(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                AppStrings.protein,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              Icon(
                Icons.egg_alt_rounded,
                size: 18,
                color: AppColors.proteinPurple,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Obx(() {
              final double progress =
                  (controller.proteinCurrent.value / controller.proteinTarget.value).clamp(0.0, 1.0);

              return SemiCircularGauge(
                progress: progress,
                size: 95,
                strokeWidth: 8,
                activeColor: AppColors.proteinPurple,
                centerChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${controller.proteinCurrent.value}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textWhite,
                      ),
                    ),
                    Text(
                      '/${controller.proteinTarget.value}g',
                      style: const TextStyle(
                        fontSize: 10,
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

  void _showProteinLogSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.modalBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Log Protein Intake',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textWhite),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded, color: AppColors.textSubTitle),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Select a quick portion to add to today\'s protein log:',
              style: TextStyle(fontSize: 12, color: AppColors.textSubTitle),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildOptionBtn('+20g', 20),
                _buildOptionBtn('+30g', 30),
                _buildOptionBtn('+50g', 50),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionBtn(String label, int grams) {
    return ElevatedButton(
      onPressed: () {
        controller.addProtein(grams);
        Get.back();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.cardBackground,
        foregroundColor: AppColors.proteinPurple,
        side: const BorderSide(color: AppColors.proteinPurple),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
