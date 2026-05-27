import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class BuildEmptyState extends StatelessWidget {
  const BuildEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColor.blue.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.event_outlined,
              size: 40.sp,
              color: AppColor.blue.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 16.h),
          AppText(
            label: "Aucun événement",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 4.h),
          AppText(
            label: "Aucun événement disponible pour le moment.",
            color: AppColor.textDescription,
            fontSize: 13.sp,
          ),
        ],
      ),
    );
  }
}
