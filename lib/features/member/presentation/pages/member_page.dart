import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/global_padding.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/list_animated.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_filters_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_search_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/active_filters_bar.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/add_member_dialog.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/filter_bottom_sheet.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/filter_icon_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/list_member_card.dart';

class MemberPage extends ConsumerStatefulWidget {
  const MemberPage({super.key});

  @override
  ConsumerState<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends ConsumerState<MemberPage> {
  final _searchCtrl = TextEditingController();
  Timer? _debounce;

  void _createMember() =>
      showDialog(context: context, builder: (_) => AddMemberDialog());

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        current: ref.read(memberFilterProvider),
        onApply: (updated) {
          ref.read(memberFilterProvider.notifier).update((_) => updated);
        },
      ),
    );
  }

  int _countActiveFilters(MemberFiltersModel f) {
    int count = 0;
    if (f.statut != null) count++;
    if (f.level != null) count++;
    if (f.isInside != null) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(memberDataProvider);
    final filters = ref.watch(memberFilterProvider);
    final activeCount = _countActiveFilters(filters);

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.blue.withValues(alpha: 0.9),
        shape: const CircleBorder(),
        onPressed: _createMember,
        child: Icon(Icons.person_add_alt, color: AppColor.white),
      ),
      body: Padding(
        padding: globalPadding(),
        child: ListAnimated(
          children: [
            // Recherche + Entonnoir
            Row(
              children: [
                Expanded(
                  child: AppInput(
                    controller: _searchCtrl,
                    keyboardType: TextInputType.text,
                    labelText: "Recherche...",
                    prefixIcon: Icons.search_outlined,
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        ref
                            .read(memberFilterProvider.notifier)
                            .update(
                              (s) => s.copyWith(
                                search: value.trim().isEmpty
                                    ? null
                                    : value.trim(),
                              ),
                            );
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                FilterIconButton(
                  activeCount: activeCount,
                  onTap: _openFilterSheet,
                ),
              ],
            ),

            // Chips des filtres actifs
            if (!filters.isEmpty) ...[
              SizedBox(height: 10.h),
              ActiveFiltersBar(
                filters: filters,
                onClear: () {
                  _searchCtrl.clear();
                  ref
                      .read(memberFilterProvider.notifier)
                      .update((_) => const MemberFiltersModel());
                },
                onRemove: (field) {
                  final f = ref.read(memberFilterProvider);
                  ref.read(memberFilterProvider.notifier).update((_) {
                    return switch (field) {
                      'search' => () {
                        _searchCtrl.clear();
                        return f.copyWith(search: null);
                      }(),
                      'statut' => f.copyWith(statut: "TOUS"),
                      'level' => f.copyWith(level: "TOUS"),
                      'isInside' => f.copyWith(isInside: null),
                      _ => f,
                    };
                  });
                },
              ),
            ],

            SizedBox(height: 16.h),

            // Liste
            Expanded(
              child: members.when(
                data: (lists) {
                  if (lists.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48.sp,
                            color: AppColor.blue.withValues(alpha: 0.4),
                          ),
                          SizedBox(height: 8.h),
                          AppText(
                            label: "Aucun membre trouvé",
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () =>
                        ref.read(memberDataProvider.notifier).refresh(),
                    child: ListView.builder(
                      itemCount: lists.length,
                      itemBuilder: (context, index) {
                        final member = lists[index];
                        return ListMemberCard(member: member);
                      },
                    ),
                  );
                },
                error: (_, _) => Center(
                  child: AppText(
                    label: "Erreur de connexion au serveur",
                    color: AppColor.red,
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }
}
