import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, this.onPressed, required this.label});

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColor.blue,
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        child: AppText(
          label: label,
          fontWeight: FontWeight.w600,
          color: AppColor.white,
          fontSize: 13.sp,
        ),
      ),
    );
  }
}
