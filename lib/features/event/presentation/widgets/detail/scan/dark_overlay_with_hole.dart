import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/detail/scan/hole_clipper.dart';

class DarkOverlayWithHole extends StatelessWidget {
  final double frameWidth;
  final double frameHeight;

  const DarkOverlayWithHole({
    super.key,
    required this.frameWidth,
    required this.frameHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HoleClipper(frameWidth: frameWidth, frameHeight: frameHeight),
      child: Container(color: Colors.black.withValues(alpha: 0.65)),
    );
  }
}
