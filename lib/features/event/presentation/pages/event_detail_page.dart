import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_detail_notifier.dart';

class EventDetailPage extends ConsumerStatefulWidget {
  const EventDetailPage({super.key, required this.eventId});

  final int eventId;

  @override
  ConsumerState<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends ConsumerState<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    final eventDetail = ref.watch(eventDetailProvider(widget.eventId));

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: eventDetail.when(
        data: (event) => _EventDetailBody(event: event),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColor.blue),
        ),
        error: (error, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 36.sp,
                  color: AppColor.red,
                ),
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
        ),
      ),
    );
  }
}

class _EventDetailBody extends StatelessWidget {
  const _EventDetailBody({required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoCards(),
                SizedBox(height: 24.h),
                _buildDescription(),
                SizedBox(height: 24.h),
                _buildMembersSection(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
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

  Widget _buildInfoCards() {
    return Row(
      children: [
        Expanded(
          child: _InfoTile(
            icon: Icons.access_time_rounded,
            label: "Début",
            value: event.startTime,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _InfoTile(
            icon: Icons.flag_rounded,
            label: "Fin",
            value: event.endTime,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _InfoTile(
            icon: Icons.people_outline_rounded,
            label: "Présents",
            value: "${event.members?.length ?? 0}",
            isAccent: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              label: "Description",
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
          ),
          child: AppText(
            label: event.eventDescription,
            fontSize: 13.sp,
            color: AppColor.textDescription,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildMembersSection() {
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

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.isAccent = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isAccent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: isAccent
            ? AppColor.blue.withValues(alpha: 0.08)
            : AppColor.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isAccent
              ? AppColor.blue.withValues(alpha: 0.2)
              : Colors.grey.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: isAccent ? AppColor.blue : AppColor.textDescription,
          ),
          SizedBox(height: 6.h),
          AppText(
            label: value,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: isAccent ? AppColor.blue : AppColor.textDescription,
          ),
          SizedBox(height: 2.h),
          AppText(
            label: label,
            fontSize: 11.sp,
            color: AppColor.textDescription,
          ),
        ],
      ),
    );
  }
}
