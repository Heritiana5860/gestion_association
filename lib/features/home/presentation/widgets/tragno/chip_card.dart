import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class ChipCard extends StatelessWidget {
  final String label;
  final Color color;
  final Color bg;
  final Color border;

  const ChipCard({
    super.key,
    required this.label,
    required this.color,
    required this.bg,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: border),
      ),
      child: AppText(
        label: label,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}
