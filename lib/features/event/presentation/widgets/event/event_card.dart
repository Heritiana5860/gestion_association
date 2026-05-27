import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/route_keys.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/event/build_content.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.pushNamed(RouteKeys.eventDetailName, extra: event.id),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.12),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Date badge
            _buildDateBadge(),
            SizedBox(width: 14.w),
            // Content
            Expanded(child: BuildContent(event: event)),
            // Arrow
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: AppColor.textDescription,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateBadge() {
    // Parse "2024-01-15" → show day + short month
    final parts = event.eventDate.split('-');
    final day = parts.length >= 3 ? parts[2] : '--';
    final months = [
      '',
      'Jan',
      'Fév',
      'Mar',
      'Avr',
      'Mai',
      'Jun',
      'Jul',
      'Aoû',
      'Sep',
      'Oct',
      'Nov',
      'Déc',
    ];
    final monthIdx = parts.length >= 2 ? int.tryParse(parts[1]) ?? 0 : 0;
    final monthStr = months[monthIdx.clamp(0, 12)];

    return Container(
      width: 48.w,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.blue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            label: day,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.blue,
          ),
          AppText(
            label: monthStr,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.blue.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}
