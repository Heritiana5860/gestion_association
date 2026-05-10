import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';

class ActiveChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const ActiveChip({super.key, required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: Chip(
        label: Text(label, style: TextStyle(fontSize: 11.sp)),
        deleteIcon: Icon(Icons.close, size: 14.sp),
        onDeleted: onRemove,
        backgroundColor: AppColor.blue.withValues(alpha: 0.1),
        side: BorderSide(color: AppColor.blue.withValues(alpha: 0.3)),
      ),
    );
  }
}
