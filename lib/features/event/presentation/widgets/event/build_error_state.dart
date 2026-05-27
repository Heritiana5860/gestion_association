import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class BuildErrorState extends StatelessWidget {
  const BuildErrorState({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 36.sp, color: AppColor.red),
            SizedBox(height: 12.h),
            AppText(
              label: "$error",
              color: AppColor.red,
              fontSize: 13.sp,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
