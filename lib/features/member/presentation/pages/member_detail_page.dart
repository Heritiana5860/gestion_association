import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/presentation/providers/cotisation/cotisation_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_delete_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_detail_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/providers/member_stats_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/action_row.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/hero_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/info_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/info_row.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/section_label.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
              SizedBox(height: 24.h),
              member.cotisations!.first.isPaid
                  ? MemberCard(member: member)
                  : SizedBox.shrink(),
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

class MemberCard extends StatelessWidget {
  const MemberCard({super.key, required this.member});
  final MemberEntity member;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label: 'Carte membre'),
        SizedBox(height: 8.h),
        Container(
          width: 320.w,
          height: 190.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF26215C), Color(0xFF534AB7), Color(0xFF7F77DD)],
              stops: [0.0, 0.6, 1.0],
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                // Cercles décoratifs d'arrière-plan
                Positioned(
                  top: -60.h,
                  right: -50.w,
                  child: _BgCircle(size: 180.w),
                ),
                Positioned(
                  bottom: -40.h,
                  left: 30.w,
                  child: _BgCircle(size: 100.w),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 18.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // En-tête
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            label: 'ASSOCIATION DES ETUDIANTS\n 7 VINAGNY',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white54,
                            letterSpacing: 1.2,
                            textAlign: TextAlign.center,
                          ),
                          _StatusBadge(label: member.statut),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      // Nom
                      AppText(
                        label: member.fullName,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      SizedBox(height: 2.h),
                      AppText(
                        label: member.numberPhone,
                        fontSize: 11.sp,
                        color: Colors.white60,
                      ),

                      const Spacer(),

                      // Pied : infos + QR
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _CardInfoRow(
                                icon: Icons.school,
                                label: member.school,
                              ),
                              SizedBox(height: 5.h),
                              _CardInfoRow(
                                icon: Icons.double_arrow,
                                label: member.level,
                              ),
                              SizedBox(height: 5.h),
                              _CardInfoRow(
                                icon: Icons.location_on,
                                label: member.address,
                              ),
                            ],
                          ),
                          _QrBox(data: member.cde),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Cercle décoratif translucide
class _BgCircle extends StatelessWidget {
  const _BgCircle({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.06),
      ),
    );
  }
}

// Badge de statut
class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.w,
        children: [
          Icon(Icons.auto_awesome, size: 10.sp, color: Colors.white),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Ligne d'info en bas de carte
class _CardInfoRow extends StatelessWidget {
  const _CardInfoRow({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6.w,
      children: [
        Icon(icon, size: 13.sp, color: Colors.white38),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}

// Boîte QR code avec fond blanc
class _QrBox extends StatelessWidget {
  const _QrBox({required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.h,
      padding: EdgeInsets.all(0.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: QrImageView(
        data: data,
        version: QrVersions.auto,
        foregroundColor: const Color(0xFF26215C),
      ),
    );
  }
}
