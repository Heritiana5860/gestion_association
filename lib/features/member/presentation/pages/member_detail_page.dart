import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_delete_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_detail_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/action_row.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/hero_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/info_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/info_row.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/section_label.dart';

class MemberDetailPage extends ConsumerStatefulWidget {
  const MemberDetailPage({super.key, required this.memberId});
  final int memberId;

  @override
  ConsumerState<MemberDetailPage> createState() => _MemberDetailPageState();
}

class _MemberDetailPageState extends ConsumerState<MemberDetailPage> {
  String selectedValue = 'Nothing selected';

  String _initials(String fullName) {
    final parts = fullName
        .trim()
        .split(' ')
        .where((p) => p.isNotEmpty)
        .toList();

    if (parts.isEmpty) return '?';
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(detailProvider(widget.memberId));

    return membersAsync.when(
      data: (member) {
        return Scaffold(
          backgroundColor: AppColor.scaffoldBackground,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => context.pop(),
            ),
            title: const AppText(
              label: 'Fiche membre',
              fontWeight: FontWeight.w600,
            ),
            centerTitle: true,
            actions: [
              PopupMenuButton(
                icon: Icon(Icons.more_horiz_rounded, color: AppColor.grey),
                color: AppColor.white,
                elevation: 8,
                shadowColor: Colors.black.withValues(alpha: 0.12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                offset: Offset(0, 8),
                onSelected: (value) {
                  if (value == 'delete') {
                    ref.read(deleteMemberProvider(widget.memberId));
                    ref.read(memberDataProvider.notifier).refresh();
                    ref.read(memberDataStats.notifier).refresh();
                    ref.read(cotisationDataProvider.notifier).refresh();

                    context.pop();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    height: 44.h,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: AppColor.red.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: AppColor.red,
                            size: 16.r,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        AppText(
                          label: 'Supprimer',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            children: [
              HeroCard(member: member, initials: _initials(member.fullName)),
              SizedBox(height: 20.h),
              ActionRow(member: member),
              SizedBox(height: 16.h),
              SectionLabel(label: 'Coordonnées'),
              SizedBox(height: 8.h),
              InfoCard(
                rows: [
                  InfoRow(
                    icon: Icons.phone_outlined,
                    color: AppColor.blue,
                    label: 'Téléphone',
                    value: member.numberPhone,
                  ),
                  InfoRow(
                    icon: Icons.location_on_outlined,
                    color: AppColor.green,
                    label: 'Adresse',
                    value: member.address,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              SectionLabel(label: 'Scolarité'),
              SizedBox(height: 8.h),
              InfoCard(
                rows: [
                  InfoRow(
                    icon: Icons.school_outlined,
                    color: AppColor.purple,
                    label: 'École',
                    value: member.school,
                  ),
                  InfoRow(
                    icon: Icons.confirmation_number,
                    color: AppColor.juan,
                    label: "Carte d'étudiant",
                    value: member.cde,
                  ),
                  InfoRow(
                    icon: Icons.workspace_premium_outlined,
                    color: AppColor.darkOrange,
                    label: 'Niveau',
                    value: member.level,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              SectionLabel(label: 'Statut'),
              SizedBox(height: 8.h),
              InfoCard(
                rows: [
                  InfoRow(
                    icon: Icons.badge_outlined,
                    color: AppColor.green,
                    label: 'Statut',
                    value: member.statut,
                  ),
                  if (member.createdAt != null)
                    InfoRow(
                      icon: Icons.calendar_today_outlined,
                      color: Colors.grey,
                      label: 'Membre depuis',
                      value: member.createdAt!,
                    ),
                ],
              ),
            ],
          ),
        );
      },
      error: (e, _) => Scaffold(
        body: Center(
          child: AppText(label: 'Erreur: $e', color: AppColor.red),
        ),
      ),
      loading: () => Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColor.blue)),
      ),
    );
  }
}
