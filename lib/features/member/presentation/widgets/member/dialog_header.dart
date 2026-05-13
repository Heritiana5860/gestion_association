import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColor.white)),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              label: "Nouveau membre",
              color: AppColor.blue,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 6.w),
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.close, color: AppColor.red),
          ),
        ],
      ),
    );
  }
}
