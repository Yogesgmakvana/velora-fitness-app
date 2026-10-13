import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Smooth glowing wave line painter for Readiness metric
class LineChartWidget extends StatelessWidget {
  final double height;
  final Color lineColors;

  const LineChartWidget({
    super.key,
    this.height = 36.0,
    this.lineColors = AppColors.primaryNeon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _WaveLinePainter(lineColor: lineColors),
      ),
    );
  }
}

class _WaveLinePainter extends CustomPainter {
  final Color lineColor;

  _WaveLinePainter({required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Smooth spline curve matching readiness chart in design
    path.moveTo(0, h * 0.6);
    path.cubicTo(w * 0.2, h * 0.6, w * 0.25, h * 0.2, w * 0.4, h * 0.35);
    path.cubicTo(w * 0.55, h * 0.5, w * 0.65, h * 0.85, w * 0.8, h * 0.25);
    path.quadraticBezierTo(w * 0.9, h * 0.4, w, h * 0.3);

    // Glowing effect
    final glowPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WaveLinePainter oldDelegate) => false;
}
