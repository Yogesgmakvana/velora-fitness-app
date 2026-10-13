import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/nav_item_button.dart';
import '../../achievements/views/achievements_tab_view.dart';
import '../../goals/views/goals_view.dart';
import '../../home/views/home_view.dart';
import '../../settings/views/settings_view.dart';
import '../../workouts/views/workouts_view.dart';
import '../controllers/main_navigation_controller.dart';

class MainNavigationView extends GetView<MainNavigationController> {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeView(),
      const AchievementsTabView(),
      const WorkoutsView(),
      const GoalsView(),
      const SettingsView(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Tab View Switcher
          Obx(() => IndexedStack(
                index: controller.currentIndex.value,
                children: pages,
              )),

          // Floating Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.navBarBackground,
                borderRadius: BorderRadius.circular(36),
                border: Border.all(
                  color: AppColors.cardBorder,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Obx(() {
                final activeIndex = controller.currentIndex.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavItemButton(
                      icon: Icons.home_rounded,
                      isActive: activeIndex == 0,
                      onTap: () => controller.changeTab(0),
                    ),
                    NavItemButton(
                      icon: Icons.card_giftcard_rounded,
                      isActive: activeIndex == 1,
                      onTap: () => controller.changeTab(1),
                    ),
                    NavItemButton(
                      icon: Icons.fitness_center_rounded,
                      isActive: activeIndex == 2,
                      onTap: () => controller.changeTab(2),
                    ),
                    NavItemButton(
                      icon: Icons.track_changes_rounded,
                      isActive: activeIndex == 3,
                      onTap: () => controller.changeTab(3),
                    ),
                    NavItemButton(
                      icon: Icons.settings_rounded,
                      isActive: activeIndex == 4,
                      onTap: () => controller.changeTab(4),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
