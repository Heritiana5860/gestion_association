import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/a.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.center,
          opacity: 0.4,
        ),
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.lightGrey),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            label: "AE7V",
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.blue,
          ),
          AppText(
            label: "Association des Etudiants \n7 Vinagny",
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        ],
      ),
    );
  }
}
