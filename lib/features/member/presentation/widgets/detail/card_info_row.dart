import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardInfoRow extends StatelessWidget {
  const CardInfoRow({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6.w,
      children: [
        Icon(icon, size: 13.sp, color: Colors.white38),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}
