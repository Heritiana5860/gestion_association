import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';

class BuildDescription extends StatelessWidget {
  const BuildDescription({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: AppColor.blue,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 8.w),
            AppText(
              label: "Description",
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
          ),
          child: AppText(
            label: event.eventDescription,
            fontSize: 13.sp,
            color: AppColor.textDescription,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
