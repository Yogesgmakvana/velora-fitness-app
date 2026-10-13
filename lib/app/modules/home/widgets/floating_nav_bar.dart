import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/nav_item_button.dart';
import '../controllers/home_controller.dart';

class FloatingNavBar extends GetView<HomeController> {
  const FloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Obx(() {
        final activeIndex = controller.currentNavIndex.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItemButton(
              icon: Icons.home_rounded,
              isActive: activeIndex == 0,
              onTap: () => controller.onNavTabSelected(0),
            ),
            NavItemButton(
              icon: Icons.card_giftcard_rounded,
              isActive: activeIndex == 1,
              onTap: () => controller.onNavTabSelected(1),
            ),
            NavItemButton(
              icon: Icons.fitness_center_rounded,
              isActive: activeIndex == 2,
              onTap: () => controller.onNavTabSelected(2),
            ),
            NavItemButton(
              icon: Icons.track_changes_rounded,
              isActive: activeIndex == 3,
              onTap: () => controller.onNavTabSelected(3),
            ),
            NavItemButton(
              icon: Icons.lightbulb_outline_rounded,
              isActive: activeIndex == 4,
              onTap: () => controller.onNavTabSelected(4),
            ),
          ],
        );
      }),
    );
  }
}
