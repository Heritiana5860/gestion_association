import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/provider_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_circular.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/empty_list.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/warning.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/presentation/providers/role_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/event/build_header.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/event/event_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/event/new_event_dialog.dart';

class EventPage extends ConsumerStatefulWidget {
  const EventPage({super.key});

  @override
  ConsumerState<EventPage> createState() => _EventPageState();
}

class _EventPageState extends ConsumerState<EventPage> {
  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventProvider);
    final role = ref.watch(roleUserProvider);

    void openDialog() {
      showDialog(context: context, builder: (context) => NewEventDialog());
    }

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      floatingActionButton: ButtonFoatingCard(
        heroTag: "event-btn",
        onPressed: () {
          role == "Membre" ? messageRoleMember(context) : openDialog();
        },
        icon: Icons.event_note,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(eventProvider.notifier).refresh(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: globalPadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    BuildHeader(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            events.when(
              data: (eventList) {
                if (eventList.isEmpty) {
                  return SliverFillRemaining(
                    child: EmptyList(
                      label: "Aucun événement trouvé",
                      icon: Icons.event,
                    ),
                  );
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
              error: (error, _) {
                return SliverFillRemaining(
                  child: errorProvider(context: context, error: error),
                );
              },

              loading: () => SliverFillRemaining(child: AppCircular()),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          ],
        ),
      ),
    );
  }
}
