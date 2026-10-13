import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Circular icon button component used for back navigation and quick actions
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 40.0,
    this.backgroundColor = AppColors.cardBackground,
    this.iconColor = AppColors.textWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.cardBorder,
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: size * 0.48,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
