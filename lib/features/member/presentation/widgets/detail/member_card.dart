import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/services/card_export_service.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/bg_circle.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/card_base.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/card_info_row.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/qr_box.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/section_label.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/status_badge.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/detail/verso_card.dart';
import 'package:share_plus/share_plus.dart';

class MemberCard extends StatefulWidget {
  const MemberCard({super.key, required this.member});
  final MemberEntity member;

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  final GlobalKey _rectoKey = GlobalKey();
  final GlobalKey _versoKey = GlobalKey();
  bool _isExporting = false;

  bool get _hasVerso => widget.member.cotisations!.first.isPaid;

  Future<void> _exportAs(String format) async {
    setState(() => _isExporting = true);

    try {
      final rectoPng = await CardExportService.captureAsPng(_rectoKey);
      final versoPng = _hasVerso
          ? await CardExportService.captureAsPng(_versoKey)
          : null;

      if (rectoPng == null) throw Exception('Capture recto échouée');

      final safeName = widget.member.fullName
          .trim()
          .replaceAll(RegExp(r'\s+'), '_')
          .toLowerCase();

      switch (format) {
        case 'png':
          final rectoPath = await CardExportService.saveBytesToFile(
            rectoPng,
            '${safeName}_recto',
            'png',
          );
          final files = [XFile(rectoPath)];
          if (versoPng != null) {
            final versoPath = await CardExportService.saveBytesToFile(
              versoPng,
              '${safeName}_verso',
              'png',
            );
            files.add(XFile(versoPath));
          }
          await Share.shareXFiles(
            files,
            text: 'Carte membre - ${widget.member.fullName}',
          );
          break;

        case 'jpg':
          final rectoJpg = CardExportService.pngToJpg(rectoPng);
          final rectoPath = await CardExportService.saveBytesToFile(
            rectoJpg!,
            '${safeName}_recto',
            'jpg',
          );
          final files = [XFile(rectoPath)];
          if (versoPng != null) {
            final versoJpg = CardExportService.pngToJpg(versoPng);
            final versoPath = await CardExportService.saveBytesToFile(
              versoJpg!,
              '${safeName}_verso',
              'jpg',
            );
            files.add(XFile(versoPath));
          }
          await Share.shareXFiles(
            files,
            text: 'Carte membre - ${widget.member.fullName}',
          );
          break;

        case 'pdf':
          final images = <Uint8List>[rectoPng];
          if (versoPng != null) images.add(versoPng);
          final pdfBytes = await CardExportService.generatePdfBytes(images);

          // Soit on imprime directement :
          await CardExportService.printPdf(pdfBytes, name: safeName);

          // Soit on enregistre + partage (au choix, décommenter si besoin) :
          // final pdfPath = await CardExportService.savePdfToFile(pdfBytes, safeName);
          // await Share.shareXFiles([XFile(pdfPath)]);
          break;
      }
    } catch (e) {
      debugPrint('Erreur export: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: AppText(label: 'Erreur export: $e')));
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final member = widget.member;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label: 'Carte membre'),
        SizedBox(height: 8.h),

        RepaintBoundary(
          key: _rectoKey,
          child: CardBase(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF26215C), Color(0xFF534AB7), Color(0xFF7F77DD)],
              stops: [0.0, 0.6, 1.0],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                children: [
                  Positioned(
                    top: -60.h,
                    right: -50.w,
                    child: BgCircle(size: 180.w),
                  ),
                  Positioned(
                    bottom: -40.h,
                    left: 30.w,
                    child: BgCircle(size: 100.w),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 18.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              label: 'Lonoky ho NGETROKY',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                              letterSpacing: 1.2,
                              textAlign: TextAlign.center,
                            ),
                            StatusBadge(label: member.statut),
                          ],
                        ),
                        SizedBox(height: 10.h),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CardInfoRow(
                                  icon: Icons.school,
                                  label: member.school ?? "",
                                ),
                                SizedBox(height: 5.h),
                                CardInfoRow(
                                  icon: Icons.double_arrow,
                                  label: member.level ?? "",
                                ),
                                SizedBox(height: 5.h),
                                CardInfoRow(
                                  icon: Icons.location_on,
                                  label: member.address ?? "",
                                ),
                              ],
                            ),
                            QrBox(data: member.cde),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 8.h),

        if (_hasVerso)
          RepaintBoundary(key: _versoKey, child: const VersoCard()),

        SizedBox(height: 12.h),

        _isExporting
            ? const Center(child: CircularProgressIndicator())
            : Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: "PNG",
                      onPressed: () => _exportAs('png'),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppButton(
                      label: "JPG",
                      onPressed: () => _exportAs('jpg'),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppButton(
                      label: "PDF",
                      onPressed: () => _exportAs('pdf'),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
