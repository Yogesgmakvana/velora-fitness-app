import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Standard dark card wrapper component with subtle border and padding
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double borderRadius;
  final Color backgroundColor;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius = 20.0,
    this.backgroundColor = AppColors.cardBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: AppColors.cardBorder,
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
