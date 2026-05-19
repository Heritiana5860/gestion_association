import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';

class ButtonFoatingCard extends StatelessWidget {
  const ButtonFoatingCard({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColor.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: AppColor.blue, width: 1.5),
      ),
      child: Icon(icon, color: AppColor.blue, size: 22.r),
    );
  }
}
