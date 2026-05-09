import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ListAnimated extends StatelessWidget {
  const ListAnimated({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: AnimateList(
        interval: 150.ms,
        effects: [
          FadeEffect(duration: 400.ms),
          MoveEffect(
            begin: const Offset(0, 30),
            curve: Curves.decelerate,
            duration: 500.ms,
          ),
        ],
        children: children,
      ),
    );
  }
}
