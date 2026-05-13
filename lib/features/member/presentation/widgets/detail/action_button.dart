import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.isPrimary = false,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isPrimary ? AppColor.blue : AppColor.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isPrimary
                ? AppColor.blue
                : Colors.black.withValues(alpha: 0.15),
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isPrimary ? Colors.white : AppColor.blue,
            ),
            SizedBox(width: 6.w),
            AppText(
              label: label,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: isPrimary ? Colors.white : AppColor.blue,
            ),
          ],
        ),
      ),
    );
  }
}
