import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/dropdown_button_pill.dart';
import '../../../widgets/share_button.dart';
import '../controllers/steps_detail_controller.dart';
import '../widgets/stats_summary_card.dart';
import '../widgets/steps_bar_chart.dart';
import '../widgets/steps_days_bar.dart';

class StepsDetailView extends GetView<StepsDetailController> {
  const StepsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundGradientStart,
              AppColors.backgroundGradientEnd,
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top App Bar Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => controller.goBack(),
                    ),
                    ShareButton(
                      onTap: () => controller.onSharePressed(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Title & Filter Dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppStrings.steps,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textWhite,
                      ),
                    ),
                    Obx(() {
                      return DropdownButtonPill(
                        label: controller.selectedFilter.value,
                        onTap: () {},
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),

                // Week Days Row
                const StepsDaysBar(),
                const SizedBox(height: 24),

                // Weekly Bar Chart
                const StepsBarChart(),
                const SizedBox(height: 24),

                // Summary Stats Cards (2 Cards)
                const StatsSummaryCards(),
                const SizedBox(height: 28),

                // "Your Steps Stats" & Tips Section
                const Text(
                  AppStrings.yourStepsStats,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  AppStrings.stepsDescription,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.textSubTitle,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  AppStrings.tipsHeader,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: AppColors.textSubTitle,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  AppStrings.setRealisticGoals,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  AppStrings.setRealisticGoalsSub,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: AppColors.textSubTitle,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
