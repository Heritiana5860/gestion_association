import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class PaidBadge extends StatelessWidget {
  final double percentage;
  const PaidBadge({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColor.green.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        label: "${percentage.toStringAsFixed(0)}% payés",
        fontSize: 10.sp,
        color: AppColor.green,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
