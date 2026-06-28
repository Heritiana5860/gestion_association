import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    super.key,
    required this.total,
    required this.label,
    this.icon,
    this.totalLabel,
  });

  final int total;
  final String label;
  final IconData? icon;
  final String? totalLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: AppColor.textDescription),
        SizedBox(width: 8.w),
        AppText(label: label, fontSize: 13.sp, fontWeight: FontWeight.w600),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColor.scaffoldBackground,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColor.lightGrey),
          ),
          child: AppText(
            label: "$total $totalLabel",
            fontSize: 11.sp,
            color: AppColor.black,
          ),
        ),
      ],
    );
  }
}
