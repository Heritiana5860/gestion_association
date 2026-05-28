import 'package:flutter/material.dart';

class HoleClipper extends CustomClipper<Path> {
  final double frameWidth;
  final double frameHeight;

  const HoleClipper({required this.frameWidth, required this.frameHeight});

  @override
  Path getClip(Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final left = centerX - frameWidth / 2;
    final top = centerY - frameHeight / 2;

    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, frameWidth, frameHeight),
          const Radius.circular(16),
        ),
      ),
    );
  }

  @override
  bool shouldReclip(HoleClipper old) =>
      old.frameWidth != frameWidth || old.frameHeight != frameHeight;
}
