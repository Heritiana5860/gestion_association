import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/domain/entities/obligation_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/presentation/widgets/item_card.dart';

class ObligationListCard extends StatelessWidget {
  const ObligationListCard({super.key, required this.item});

  final ObligationEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),

        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),

          childrenPadding: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
            bottom: 14.h,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
            side: BorderSide.none,
          ),

          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
            side: BorderSide.none,
          ),

          leading: Container(
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

          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                label: "Obligations",
                fontSize: 12.sp,
                color: AppColor.textDescription,
              ),

              SizedBox(height: 4.h),

              AppText(
                label: "${item.year}",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),

          children: [
            ItemCard(item: item.doyenAncienIn, label: "Doyens/Anciens interne"),

            ItemCard(
              item: item.doyenAncienExt,
              label: "Doyens/Anciens externe",
            ),

            ItemCard(item: item.noviceAmountIn, label: "Novices interne"),

            ItemCard(item: item.noviceAmountExt, label: "Novices externe"),
          ],
        ),
      ),
    );
  }
}
