import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrBox extends StatelessWidget {
  const QrBox({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.h,
      padding: EdgeInsets.all(0.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: QrImageView(
        size: 64.r,
        data: data,
        version: QrVersions.auto,
        // foregroundColor: const Color(0xFF26215C),
        eyeStyle: QrEyeStyle(color: AppColor.black),
      ),
    );
  }
}
