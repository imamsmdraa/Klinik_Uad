import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ClinicLogo extends StatelessWidget {
  const ClinicLogo({
    super.key,
    this.size = 56,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = Colors.white,
  });

  final double size;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    if (backgroundColor == Colors.transparent) {
      return Image.asset(
        'assets/icon/logo_klinik_uad.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: CustomPaint(painter: _LungsLogoPainter(foregroundColor)),
    );
  }
}

class _LungsLogoPainter extends CustomPainter {
  const _LungsLogoPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.075
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final fill = Paint()
      ..color = color.withAlpha(35)
      ..style = PaintingStyle.fill;
    final center = size.width / 2;

    final stem = Path()
      ..moveTo(center, size.height * 0.18)
      ..lineTo(center, size.height * 0.43)
      ..moveTo(center, size.height * 0.27)
      ..quadraticBezierTo(
        size.width * 0.32,
        size.height * 0.18,
        size.width * 0.25,
        size.height * 0.31,
      )
      ..moveTo(center, size.height * 0.27)
      ..quadraticBezierTo(
        size.width * 0.68,
        size.height * 0.18,
        size.width * 0.75,
        size.height * 0.31,
      );
    canvas.drawPath(stem, stroke);

    final leftLung = Path()
      ..moveTo(center - size.width * 0.06, size.height * 0.4)
      ..cubicTo(
        size.width * 0.28,
        size.height * 0.35,
        size.width * 0.12,
        size.height * 0.46,
        size.width * 0.2,
        size.height * 0.78,
      )
      ..cubicTo(
        size.width * 0.27,
        size.height * 0.9,
        size.width * 0.44,
        size.height * 0.85,
        center - size.width * 0.06,
        size.height * 0.68,
      )
      ..close();
    final rightLung = Path()
      ..moveTo(center + size.width * 0.06, size.height * 0.4)
      ..cubicTo(
        size.width * 0.72,
        size.height * 0.35,
        size.width * 0.88,
        size.height * 0.46,
        size.width * 0.8,
        size.height * 0.78,
      )
      ..cubicTo(
        size.width * 0.73,
        size.height * 0.9,
        size.width * 0.56,
        size.height * 0.85,
        center + size.width * 0.06,
        size.height * 0.68,
      )
      ..close();

    canvas.drawPath(leftLung, fill);
    canvas.drawPath(rightLung, fill);
    canvas.drawPath(leftLung, stroke);
    canvas.drawPath(rightLung, stroke);
  }

  @override
  bool shouldRepaint(covariant _LungsLogoPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
