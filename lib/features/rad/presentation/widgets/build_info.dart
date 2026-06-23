import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class BuildInfo extends StatelessWidget {
  const BuildInfo({
    super.key,
    this.icon,
    required this.label,
    this.maxLines,
    this.overflow,
    this.color,
  });

  final IconData? icon;
  final String label;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6.w,
      children: [
        Icon(icon, color: AppColor.grey, size: 16.r),
        Flexible(
          child: AppText(
            label: label,
            maxLines: maxLines,
            overflow: overflow,
            color: color,
          ),
        ),
      ],
    );
  }
}
