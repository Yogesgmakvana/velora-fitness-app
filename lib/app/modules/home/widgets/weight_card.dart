import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_card.dart';
import '../controllers/home_controller.dart';

class WeightCard extends GetView<HomeController> {
  const WeightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () => _showWeightLogSheet(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                AppStrings.currentWeight,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              Icon(
                Icons.speed_rounded,
                size: 18,
                color: AppColors.weightOrange,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() {
            return Center(
              child: Text(
                '${controller.currentWeight.value.toStringAsFixed(1)} kg',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.weightOrange,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showWeightLogSheet(BuildContext context) {
    final RxDouble tempWeight = controller.currentWeight.value.obs;

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
                  'Log Today\'s Weight',
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
                    '${tempWeight.value.toStringAsFixed(1)} kg',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.weightOrange),
                  )),
            ),
            Obx(() {
              return Slider(
                value: tempWeight.value,
                min: 40.0,
                max: 130.0,
                divisions: 180,
                activeColor: AppColors.weightOrange,
                inactiveColor: AppColors.cardBorder,
                onChanged: (val) => tempWeight.value = val,
              );
            }),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.updateWeight(tempWeight.value);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.weightOrange,
                  foregroundColor: AppColors.textDark,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Save Weight Entry', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
