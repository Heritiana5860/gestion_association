import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';

class BuildMembersSection extends StatelessWidget {
  const BuildMembersSection({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    final members = event.members ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 3.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                    color: AppColor.blue,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(width: 8.w),
                AppText(
                  label: "Membres présents",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColor.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: AppText(
                label: "${members.length}",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        if (members.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.people_outline_rounded,
                  size: 28.sp,
                  color: AppColor.textDescription,
                ),
                SizedBox(height: 8.h),
                AppText(
                  label: "Aucun membre présent",
                  fontSize: 13.sp,
                  color: AppColor.textDescription,
                ),
              ],
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: members.length,
              separatorBuilder: (_, _) => Divider(
                height: 1,
                indent: 56.w,
                color: Colors.grey.withValues(alpha: 0.1),
              ),
              itemBuilder: (context, index) {
                final member = members[index];
                // Initials from member name
                final nameParts = (member.fullName).trim().split(' ');
                final initials = nameParts.length >= 2
                    ? '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase()
                    : (member.fullName).substring(0, 1).toUpperCase();

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.r,
                        backgroundColor: AppColor.blue.withValues(alpha: 0.1),
                        child: AppText(
                          label: initials,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blue,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: AppText(
                          label: member.fullName,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.check_circle_rounded,
                        size: 18.sp,
                        color: Colors.green.shade400,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
