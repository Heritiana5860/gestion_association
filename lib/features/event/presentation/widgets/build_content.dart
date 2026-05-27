import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';

class BuildContent extends StatelessWidget {
  const BuildContent({super.key, required this.event});

  final EventEntity event;

  // "2025-06-15" → "15/06/2025"
  String _formatDate(String date) {
    try {
      final d = DateTime.parse(date);
      return "${d.day.toString().padLeft(2, '0')}/"
          "${d.month.toString().padLeft(2, '0')}/"
          "${d.year}";
    } catch (_) {
      return date;
    }
  }

  // "2025-06-15T14:00:00" → "14:00"
  String _formatTime(String dateTime) {
    try {
      final dt = DateTime.parse(dateTime);
      return "${dt.hour.toString().padLeft(2, '0')}:"
          "${dt.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        AppText(
          label: event.eventName,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        AppText(
          label: event.eventDescription,
          color: AppColor.textDescription,
          fontSize: 12.sp,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        // Date
        Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 13.sp,
              color: AppColor.textDescription,
            ),
            SizedBox(width: 4.w),
            AppText(
              label: _formatDate(event.eventDate), // "15/06/2025"
              fontSize: 12.sp,
              color: AppColor.textDescription,
            ),
          ],
        ),
        SizedBox(height: 2.h),
        // Heure + membres
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 13.sp,
              color: AppColor.textDescription,
            ),
            SizedBox(width: 4.w),
            AppText(
              label:
                  "${_formatTime(event.startTime)} – ${_formatTime(event.endTime)}", // "14:00 – 16:00"
              fontSize: 12.sp,
              color: AppColor.textDescription,
            ),
            if (event.members != null && event.members!.isNotEmpty) ...[
              SizedBox(width: 12.w),
              Icon(
                Icons.people_outline_rounded,
                size: 13.sp,
                color: AppColor.blue.withValues(alpha: 0.7),
              ),
              SizedBox(width: 4.w),
              AppText(
                label: "${event.members!.length} présent(s)",
                fontSize: 12.sp,
                color: AppColor.blue.withValues(alpha: 0.7),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
