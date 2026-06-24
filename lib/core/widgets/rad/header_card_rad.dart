import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class HeaderCardRAD extends StatelessWidget {
  const HeaderCardRAD({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(label: title, fontWeight: FontWeight.w800, fontSize: 18.sp),
          AppText(label: description, color: AppColor.textDescription),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
