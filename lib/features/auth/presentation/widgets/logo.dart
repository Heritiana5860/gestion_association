import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SvgPicture.asset(
        "assets/logo/ae7v.svg",
        width: 80.w,
        height: 80.h,
      ),
    );
  }
}
