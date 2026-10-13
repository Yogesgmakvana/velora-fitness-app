import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../core/constants/app_colors.dart';

/// Shimmer skeleton card loading placeholder
class ShimmerCardLoader extends StatelessWidget {
  final double height;
  final double borderRadius;

  const ShimmerCardLoader({
    super.key,
    this.height = 120.0,
    this.borderRadius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardBackground,
      highlightColor: AppColors.cardBorder,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Shimmer grid loader placeholder for home dashboard
class DashboardShimmerLoader extends StatelessWidget {
  const DashboardShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: const [
              ShimmerCardLoader(height: 110),
              SizedBox(height: 14),
              ShimmerCardLoader(height: 160),
              SizedBox(height: 14),
              ShimmerCardLoader(height: 130),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            children: const [
              ShimmerCardLoader(height: 120),
              SizedBox(height: 14),
              ShimmerCardLoader(height: 100),
              SizedBox(height: 14),
              ShimmerCardLoader(height: 130),
              SizedBox(height: 14),
              ShimmerCardLoader(height: 80),
            ],
          ),
        ),
      ],
    );
  }
}
