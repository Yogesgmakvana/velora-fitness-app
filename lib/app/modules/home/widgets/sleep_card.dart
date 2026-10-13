import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_card.dart';
import '../controllers/home_controller.dart';

class SleepCard extends GetView<HomeController> {
  const SleepCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () => _showSleepEditSheet(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                AppStrings.sleep,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              Icon(
                Icons.nightlight_round,
                size: 18,
                color: AppColors.sleepYellow,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() {
            final double currentHours = controller.sleepHours.value;
            final double targetHours = controller.sleepGoalHours.value;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  currentHours.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  AppStrings.sleepUnit,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textWhite,
                  ),
                ),
                const Spacer(),
                Text(
                  '/${targetHours.toStringAsFixed(0)}hrs',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSubTitle,
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: 14),
          // Progress bar line
          Obx(() {
            final double ratio = (controller.sleepHours.value / controller.sleepGoalHours.value).clamp(0.0, 1.0);
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 6,
                backgroundColor: AppColors.chartGridLine,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.sleepYellow),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showSleepEditSheet(BuildContext context) {
    final RxDouble tempHours = controller.sleepHours.value.obs;

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
                  'Log Sleep Duration',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textWhite),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded, color: AppColors.textSubTitle),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Obx(() => Text(
                    '${tempHours.value.toStringAsFixed(1)} hrs',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.sleepYellow),
                  )),
            ),
            Obx(() {
              return Slider(
                value: tempHours.value,
                min: 3.0,
                max: 12.0,
                divisions: 18,
                activeColor: AppColors.sleepYellow,
                inactiveColor: AppColors.cardBorder,
                onChanged: (val) => tempHours.value = val,
              );
            }),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.updateSleepHours(tempHours.value);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.sleepYellow,
                  foregroundColor: AppColors.textDark,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Save Sleep Duration', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
