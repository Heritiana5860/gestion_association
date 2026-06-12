import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardBase extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  const CardBase({
    super.key,
    required this.child,
    this.gradient,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 190.h,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        gradient: gradient,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(16.r), child: child),
    );
  }
}
