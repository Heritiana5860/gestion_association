import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/route_keys.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_notifier.dart';

class EventPage extends ConsumerStatefulWidget {
  const EventPage({super.key});

  @override
  ConsumerState<EventPage> createState() => _EventPageState();
}

class _EventPageState extends ConsumerState<EventPage> {
  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventProvider);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: globalPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                _buildHeader(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
        events.when(
          data: (eventList) {
            if (eventList.isEmpty) {
              return SliverFillRemaining(child: _buildEmptyState());
            }
            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: EventCard(event: eventList[index]),
                  );
                }, childCount: eventList.length),
              ),
            );
          },
          error: (error, _) =>
              SliverFillRemaining(child: _buildErrorState(error)),
          loading: () => SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColor.blue,
                strokeWidth: 2.5,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: AppColor.blue,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 10.w),
              AppText(
                label: "Événements",
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: AppText(
              label: "Sélectionnez un événement pour consulter les présences.",
              color: AppColor.textDescription,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColor.blue.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.event_outlined,
              size: 40.sp,
              color: AppColor.blue.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 16.h),
          AppText(
            label: "Aucun événement",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 4.h),
          AppText(
            label: "Aucun événement disponible pour le moment.",
            color: AppColor.textDescription,
            fontSize: 13.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 36.sp, color: AppColor.red),
            SizedBox(height: 12.h),
            AppText(
              label: "$error",
              color: AppColor.red,
              fontSize: 13.sp,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

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
            Expanded(child: _buildContent()),
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

  Widget _buildContent() {
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
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 13.sp,
              color: AppColor.textDescription,
            ),
            SizedBox(width: 4.w),
            AppText(
              label: "${event.startTime} – ${event.endTime}",
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
