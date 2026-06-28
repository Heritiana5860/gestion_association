import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class EntiteCard extends StatelessWidget {
  final String abbr;
  final String initials;
  final Color color;
  final Color bg;

  const EntiteCard({
    super.key,
    required this.abbr,
    required this.initials,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColor.lightGrey),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: AppText(
              label: initials,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                label: abbr,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              AppText(
                label: "Sous-entité",
                fontSize: 11.sp,
                color: AppColor.textDescription,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
