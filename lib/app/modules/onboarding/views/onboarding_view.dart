import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/circular_progress_ring.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

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
            stops: [0.0, 0.5],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar Page Indicators
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(3, (index) {
                        return Obx(() {
                          final isActive = controller.currentPage.value == index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.only(right: 6),
                            width: isActive ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isActive ? AppColors.primaryNeon : AppColors.cardBorder,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        });
                      }),
                    ),
                    Obx(() {
                      if (controller.currentPage.value < 2) {
                        return TextButton(
                          onPressed: () => controller.finishOnboarding(),
                          child: const Text(
                            'Skip',
                            style: TextStyle(color: AppColors.textSubTitle),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
              ),

              // Page View Body
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  children: [
                    _buildSlide1(),
                    _buildSlide2(),
                    _buildSlide3(),
                  ],
                ),
              ),

              // Bottom Primary Button
              Padding(
                padding: const EdgeInsets.all(24),
                child: Obx(() {
                  final isLast = controller.currentPage.value == 2;
                  return PrimaryButton(
                    text: isLast ? "Let's Get Started" : 'Continue',
                    onTap: () => controller.nextPage(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide1() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressRing(
            progress: 0.72,
            size: 160,
            strokeWidth: 12,
            progressColor: AppColors.primaryNeon,
            showOuterRays: true,
            centerChild: Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cardBackground,
              ),
              child: const Icon(
                Icons.fitness_center_rounded,
                color: AppColors.primaryNeon,
                size: 56,
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'Track Your Fitness & Life',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Effortlessly monitor your daily steps, workouts, sleep, and nutrition in a dark premium dashboard.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppColors.textSubTitle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Set Your Profile & Goals',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Customize your preferences to get accurate fitness insights.',
            style: TextStyle(fontSize: 13, color: AppColors.textSubTitle),
          ),
          const SizedBox(height: 28),

          // Name Input
          const Text(
            'Your Name',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textWhite),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.nameTextController,
            style: const TextStyle(color: AppColors.textWhite),
            decoration: InputDecoration(
              hintText: 'Enter your name',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.cardBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.cardBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.primaryNeon),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Step Goal Selector
          const Text(
            'Daily Step Target',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textWhite),
          ),
          const SizedBox(height: 12),
          Obx(() {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: controller.stepGoalsList.map((goal) {
                final isSelected = controller.selectedStepGoal.value == goal;
                return ChoiceChip(
                  label: Text('$goal steps'),
                  selected: isSelected,
                  onSelected: (_) => controller.selectedStepGoal.value = goal,
                  selectedColor: AppColors.primaryNeon,
                  backgroundColor: AppColors.cardBackground,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.textDark : AppColors.textWhite,
                    fontWeight: FontWeight.bold,
                  ),
                  side: BorderSide(
                    color: isSelected ? AppColors.primaryNeon : AppColors.cardBorder,
                  ),
                );
              }).toList(),
            );
          }),
          const SizedBox(height: 24),

          // Target Weight Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Target Weight',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textWhite),
              ),
              Obx(() => Text(
                    '${controller.selectedWeight.value.toStringAsFixed(1)} kg',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNeon,
                    ),
                  )),
            ],
          ),
          Obx(() {
            return Slider(
              value: controller.selectedWeight.value,
              min: 40,
              max: 120,
              divisions: 160,
              activeColor: AppColors.primaryNeon,
              inactiveColor: AppColors.cardBorder,
              onChanged: (val) => controller.selectedWeight.value = val,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSlide3() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.cardBackground,
            ),
            child: const Icon(
              Icons.sensors_rounded,
              size: 48,
              color: AppColors.primaryNeon,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Enable Step Tracking',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'To count your live daily steps accurately, VELORA needs Physical Activity permission on your device.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.textSubTitle),
          ),
          const SizedBox(height: 28),
          Obx(() {
            final granted = controller.isPermissionGranted.value;
            return OutlinedButton.icon(
              onPressed: () => controller.requestActivityPermission(),
              icon: Icon(
                granted ? Icons.check_circle_rounded : Icons.security_rounded,
                color: granted ? AppColors.primaryNeon : AppColors.textWhite,
              ),
              label: Text(
                granted ? 'Permission Granted' : 'Grant Activity Permission',
                style: TextStyle(
                  color: granted ? AppColors.primaryNeon : AppColors.textWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: granted ? AppColors.primaryNeon : AppColors.cardBorder,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
