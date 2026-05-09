import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/sizes/size_border_radius.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/sizes/size_padding.dart';

class SociauxCard extends StatelessWidget {
  const SociauxCard({super.key, required this.imagePath, this.onTap});
  final String imagePath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(SizeBorderRadius.cardRadius),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(SizePadding.cardPadding),
            height: 70.h,
            width: 70.w,
            child: Center(child: SvgPicture.asset(imagePath)),
          ),
        ),
      ),
    );
  }
}
