import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/detail/build_app_bar.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/detail/build_description.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/detail/build_info_cards.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/detail/build_members_section.dart';

class EventDetailBody extends StatelessWidget {
  const EventDetailBody({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BuildAppBar(event: event),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildInfoCards(event: event),
                SizedBox(height: 24.h),
                BuildDescription(event: event),
                SizedBox(height: 24.h),
                BuildMembersSection(event: event),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
