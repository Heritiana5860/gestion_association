import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/data/list_entite.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/home/presentation/widgets/entite/entite_card.dart';

class ListSousEntite extends StatelessWidget {
  const ListSousEntite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                label: "Sous-entités de l'association",
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.green.withValues(alpha: 0.3),
                  border: Border.all(color: AppColor.green, width: 2.w),
                ),
                child: AppText(
                  label: "${listEntite.length}",
                  fontWeight: FontWeight.bold,
                  color: AppColor.green,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...List.generate(listEntite.length, (i) {
            final e = listEntite[i];
            final initials = (e['abbr'] as String).substring(0, 2);
            return Padding(
              padding: EdgeInsets.only(
                bottom: i < listEntite.length - 1 ? 8.h : 0,
              ),
              child: EntiteCard(
                abbr: e['abbr'] as String,
                initials: initials,
                color: e['color'] as Color,
                bg: e['bg'] as Color,
              ),
            );
          }),
        ],
      ),
    );
  }
}
