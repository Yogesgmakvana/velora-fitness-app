import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Custom Circular Progress Ring Painter for Steps and Achievements
class CircularProgressRing extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final double strokeWidth;
  final Color progressColor;
  final Color trackColor;
  final Widget? centerChild;
  final bool showOuterRays;

  const CircularProgressRing({
    super.key,
    required this.progress,
    this.size = 120.0,
    this.strokeWidth = 8.0,
    this.progressColor = AppColors.primaryNeon,
    this.trackColor = AppColors.chartGridLine,
    this.centerChild,
    this.showOuterRays = false,
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
            painter: _RingPainter(
              progress: progress,
              strokeWidth: strokeWidth,
              progressColor: progressColor,
              trackColor: trackColor,
              showOuterRays: showOuterRays,
            ),
          ),
          ?centerChild,
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color trackColor;
  final bool showOuterRays;

  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
    required this.trackColor,
    required this.showOuterRays,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw outer festive ticks/rays if requested (Achievements ring)
    if (showOuterRays) {
      final rayPaint = Paint()
        ..color = AppColors.sleepYellow.withValues(alpha: 0.7)
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round;

      const int rayCount = 18;
      final rayRadius = radius + strokeWidth + 6;
      const rayLength = 8.0;

      for (int i = 0; i < rayCount; i++) {
        final angle = (i * 2 * math.pi) / rayCount;
        final start = Offset(
          center.dx + rayRadius * math.cos(angle),
          center.dy + rayRadius * math.sin(angle),
        );
        final end = Offset(
          center.dx + (rayRadius + rayLength) * math.cos(angle),
          center.dy + (rayRadius + rayLength) * math.sin(angle),
        );
        canvas.drawLine(start, end, rayPaint);
      }
    }

    // Background track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    // Active progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    final sweepAngle = 2 * math.pi * progress.clamp(0.0, 1.0);
    // Start angle from top (-pi / 2)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.showOuterRays != showOuterRays;
  }
}
