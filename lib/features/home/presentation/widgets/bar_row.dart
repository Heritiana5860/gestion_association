import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class BarRow extends StatelessWidget {
  final String label;
  final double pct;
  final Color color;
  const BarRow({
    super.key,
    required this.label,
    required this.pct,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 64.w,
          child: AppText(
            label: label,
            fontSize: 10.sp,
            color: AppColor.textDescription,
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99.r),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 8.h,
              backgroundColor: AppColor.lightGrey,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        SizedBox(width: 6.w),
        SizedBox(
          width: 32.w,
          child: AppText(
            label: "${(pct * 100).round()}%",
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
