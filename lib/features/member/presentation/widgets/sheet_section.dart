import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class SheetSection extends StatelessWidget {
  final String title;
  final Widget child;

  const SheetSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label: title,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
        ),
        SizedBox(height: 10.h),
        child,
      ],
    );
  }
}
