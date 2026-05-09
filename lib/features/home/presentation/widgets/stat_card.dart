import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value, label;
  final Color color;
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColor.lightGrey),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(height: 4.h),
            AppText(
              label: value,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            AppText(
              label: label,
              fontSize: 10.sp,
              color: AppColor.textDescription,
            ),
          ],
        ),
      ),
    );
  }
}
