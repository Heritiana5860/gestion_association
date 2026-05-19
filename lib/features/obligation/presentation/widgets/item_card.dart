import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, required this.label});

  final double item;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// ICON
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColor.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColor.blue,
              size: 22.sp,
            ),
          ),

          SizedBox(width: 14.w),

          /// TEXTS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label: label,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),

                SizedBox(height: 4.h),

                AppText(
                  label: "Montant",
                  color: AppColor.textDescription,
                  fontSize: 12.sp,
                ),
              ],
            ),
          ),

          /// PRICE
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColor.blue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: AppText(
              label: "${item.toStringAsFixed(0)} Ar",
              color: AppColor.blue,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
