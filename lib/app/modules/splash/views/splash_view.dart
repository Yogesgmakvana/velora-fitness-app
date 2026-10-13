import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/circular_progress_ring.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Reference controller to ensure GetView binding is active
    controller.initialized;

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
            stops: [0.0, 0.6],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Glowing Animated Logo Ring
              CircularProgressRing(
                progress: 0.85,
                size: 140,
                strokeWidth: 10,
                progressColor: AppColors.primaryNeon,
                showOuterRays: true,
                centerChild: Container(
                  width: 115,
                  height: 115,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.modalBackground,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.directions_run_rounded,
                      color: AppColors.primaryNeon,
                      size: 52,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // App Name
              const Text(
                AppStrings.appName,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4.0,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 8),

              // Tagline
              const Text(
                'FITNESS & LIFE TRACKER',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSubTitle,
                ),
              ),
              const SizedBox(height: 48),

              // Subtle Loading Indicator
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryNeon),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
