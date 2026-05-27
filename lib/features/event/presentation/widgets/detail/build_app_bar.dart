import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    // Parse date
    final parts = event.eventDate.split('-');
    final months = [
      '',
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre',
    ];
    final day = parts.length >= 3 ? parts[2] : '--';
    final monthIdx = parts.length >= 2 ? int.tryParse(parts[1]) ?? 0 : 0;
    final month = months[monthIdx.clamp(0, 12)];
    final year = parts.isNotEmpty ? parts[0] : '';

    return SliverAppBar(
      expandedHeight: 180.h,
      pinned: true,
      backgroundColor: AppColor.blue,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColor.blue, AppColor.blue.withValues(alpha: 0.75)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 48.h, 20.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: AppText(
                      label: "$day $month $year",
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  AppText(
                    label: event.eventName,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      title: AppText(
        label: event.eventName,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      centerTitle: true,
    );
  }
}
