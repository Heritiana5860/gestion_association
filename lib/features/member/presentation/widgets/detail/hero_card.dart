import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/badge_card.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key, required this.member, required this.initials});
  final MemberEntity member;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36.r,
            backgroundColor: AppColor.blue.withValues(alpha: 0.1),
            child: AppText(
              label: initials,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.blue,
            ),
          ),
          SizedBox(height: 12.h),
          AppText(
            label: member.fullName,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            children: [
              BadgeCard(label: member.statut, color: AppColor.blue),
              BadgeCard(
                label: member.isInside ? 'Interne' : 'Externe',
                color: AppColor.green,
              ),
              BadgeCard(label: member.level ?? "", color: const Color(0xFF854F0B)),
              BadgeCard(
                label: member.cotisations!.first.isPaid ? "Payé" : "${member.cotisations?.first.amount} Ar",
                color: member.cotisations!.first.isPaid
                    ? AppColor.green
                    : AppColor.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
