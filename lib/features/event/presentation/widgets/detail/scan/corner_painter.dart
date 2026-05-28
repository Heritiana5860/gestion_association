import 'package:flutter/material.dart';

// Widget de coin décoratif
class CornerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double cornerLength;

  const CornerPainter({
    required this.color,
    required this.strokeWidth,
    required this.cornerLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final r = 10.0; // rayon arrondi des coins

    // Coin haut-gauche
    canvas.drawPath(
      Path()
        ..moveTo(0, cornerLength)
        ..lineTo(0, r)
        ..arcToPoint(Offset(r, 0), radius: Radius.circular(r))
        ..lineTo(cornerLength, 0),
      paint,
    );
    // Coin haut-droit
    canvas.drawPath(
      Path()
        ..moveTo(size.width - cornerLength, 0)
        ..lineTo(size.width - r, 0)
        ..arcToPoint(Offset(size.width, r), radius: Radius.circular(r))
        ..lineTo(size.width, cornerLength),
      paint,
    );
    // Coin bas-droit
    canvas.drawPath(
      Path()
        ..moveTo(size.width, size.height - cornerLength)
        ..lineTo(size.width, size.height - r)
        ..arcToPoint(
          Offset(size.width - r, size.height),
          radius: Radius.circular(r),
        )
        ..lineTo(size.width - cornerLength, size.height),
      paint,
    );
    // Coin bas-gauche
    canvas.drawPath(
      Path()
        ..moveTo(cornerLength, size.height)
        ..lineTo(r, size.height)
        ..arcToPoint(Offset(0, size.height - r), radius: Radius.circular(r))
        ..lineTo(0, size.height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(CornerPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}
