import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isAccent = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isAccent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: isAccent
            ? AppColor.blue.withValues(alpha: 0.08)
            : AppColor.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isAccent
              ? AppColor.blue.withValues(alpha: 0.2)
              : Colors.grey.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: isAccent ? AppColor.blue : AppColor.textDescription,
          ),
          SizedBox(height: 6.h),
          AppText(
            label: value,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: isAccent ? AppColor.blue : AppColor.textDescription,
          ),
          SizedBox(height: 2.h),
          AppText(
            label: label,
            fontSize: 11.sp,
            color: AppColor.textDescription,
          ),
        ],
      ),
    );
  }
}
