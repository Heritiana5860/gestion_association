import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: AppText(
        label: label,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}
