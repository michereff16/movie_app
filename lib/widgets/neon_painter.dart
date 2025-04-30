import 'package:flutter/material.dart';

class NeonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFFF00BF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..maskFilter = MaskFilter.blur(BlurStyle.solid, 5);

    final path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(10),
          ),
        );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
