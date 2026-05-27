import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: AppColor.blue,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 10.w),
              AppText(
                label: "Événements",
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: AppText(
              label: "Sélectionnez un événement pour consulter les présences.",
              color: AppColor.textDescription,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
