import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../controllers/steps_detail_controller.dart';

class StepsBarChart extends GetView<StepsDetailController> {
  const StepsBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    const yAxisLabels = ['14k', '10k', '6k', '4k', '2k'];
    const maxK = 14.0;

    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          // Y-Axis Grid & Labels
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(yAxisLabels.length, (index) {
                final label = yAxisLabels[index];
                final isGoalLine = label == '10k';

                return Row(
                  children: [
                    SizedBox(
                      width: 28,
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: isGoalLine
                          ? LayoutBuilder(
                              builder: (context, constraints) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: CustomPaint(
                                        size: Size(constraints.maxWidth, 1),
                                        painter: _DashedLinePainter(),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.cardBackground,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: AppColors.cardBorder,
                                        ),
                                      ),
                                      child: const Text(
                                        AppStrings.goal,
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textWhite,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : Container(
                              height: 1,
                              color: AppColors.chartGridLine.withValues(alpha: 0.5),
                            ),
                    ),
                  ],
                );
              }),
            ),
          ),

          // Bars & Percentage Overlays
          Positioned(
            left: 36,
            right: 0,
            bottom: 0,
            top: 20,
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(controller.weeklyStats.length, (index) {
                  final stat = controller.weeklyStats[index];
                  final isSelected = controller.selectedBarIndex.value == index;

                  // Calculate relative height percentage against maxK (14k = 1.0)
                  final double barValueK = (stat.percentage * 10.0) / 100.0;
                  final double heightRatio = (barValueK / maxK).clamp(0.0, 1.0);

                  return GestureDetector(
                    onTap: () => controller.selectBar(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Percentage Label above bar if percentage > 0
                        if (stat.percentage > 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              '${stat.percentage}%',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: stat.percentage >= 100
                                    ? AppColors.primaryNeon
                                    : AppColors.textWhite,
                              ),
                            ),
                          )
                        else
                          const SizedBox(height: 18),

                        // Animated Bar
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 18,
                          height: stat.percentage > 0 ? (130 * heightRatio) : 4,
                          decoration: BoxDecoration(
                            color: stat.percentage >= 100
                                ? AppColors.primaryNeon
                                : (stat.percentage > 0
                                    ? AppColors.primaryNeonDark
                                    : AppColors.barMuted),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: isSelected && stat.percentage > 0
                                ? [
                                    BoxShadow(
                                      color: AppColors.primaryNeon.withValues(alpha: 0.5),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // X-Axis Day Name
                        Text(
                          stat.dayName,
                          style: TextStyle(
                            fontSize: 10,
                            color: isSelected ? AppColors.textWhite : AppColors.textMuted,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.chartGoalLine
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
