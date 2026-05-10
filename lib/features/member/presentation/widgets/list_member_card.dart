import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';

class ListMemberCard extends StatelessWidget {
  const ListMemberCard({super.key, required this.member});

  final MemberEntity member;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColor.blue.withValues(alpha: 0.1),
          radius: 18.r,
          child: AppText(
            label: member.fullName.length >= 2
                ? member.fullName.substring(0, 2)
                : member.fullName,
            fontWeight: FontWeight.w700,
          ),
        ),
        title: AppText(
          label: member.fullName,
          fontWeight: FontWeight.w700,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: AppText(label: member.numberPhone),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.visibility_rounded),
        ),
      ),
    );
  }
}
