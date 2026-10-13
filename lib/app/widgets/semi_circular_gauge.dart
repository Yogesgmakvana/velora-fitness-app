import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Semi-circular / arc gauge component for Protein and Calories metrics
class SemiCircularGauge extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final double strokeWidth;
  final Color activeColor;
  final Color trackColor;
  final Widget? centerChild;

  const SemiCircularGauge({
    super.key,
    required this.progress,
    this.size = 110.0,
    this.strokeWidth = 10.0,
    required this.activeColor,
    this.trackColor = AppColors.chartGridLine,
    this.centerChild,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _GaugePainter(
              progress: progress,
              strokeWidth: strokeWidth,
              activeColor: activeColor,
              trackColor: trackColor,
            ),
          ),
          ?centerChild,
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color activeColor;
  final Color trackColor;

  _GaugePainter({
    required this.progress,
    required this.strokeWidth,
    required this.activeColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background track arc (starts from -220deg to 40deg)
    const startAngle = 0.75 * math.pi; // ~135 degrees
    const totalSweepAngle = 1.5 * math.pi; // ~270 degrees arc

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalSweepAngle,
      false,
      trackPaint,
    );

    // Active progress arc
    final activeSweep = totalSweepAngle * progress.clamp(0.0, 1.0);
    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      activeSweep,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.activeColor != activeColor;
  }
}
