import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

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
        Flexible(
          child: AppText(
            label: label,
            fontSize: 11.sp,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}
