import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return AppText(
      label: "TRAGNAMBO",
      fontSize: 24.sp,
      fontWeight: FontWeight.w800,
      color: AppColor.blue,
      letterSpacing: 1.6,
    );
  }
}
