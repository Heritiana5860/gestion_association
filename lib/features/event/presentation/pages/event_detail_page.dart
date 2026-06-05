import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_detail_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/detail/event_detail_body.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/detail/scan/qr_scanner_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class EventDetailPage extends ConsumerStatefulWidget {
  const EventDetailPage({super.key, this.eventId});

  final int? eventId;

  @override
  ConsumerState<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends ConsumerState<EventDetailPage> {
  bool isWithinEventTime(EventEntity event) {
    final now = DateTime.now().toUtc(); // ← forcer UTC
    final start = DateTime.parse(event.startTime).toUtc();
    final end = DateTime.parse(event.endTime).toUtc();

    debugPrint('now UTC:   $now');
    debugPrint('start UTC: $start');
    debugPrint('end UTC:   $end');
    debugPrint('isAfterStart: ${now.isAfter(start)}');
    debugPrint('isBeforeEnd:  ${now.isBefore(end)}');

    return now.isAfter(start) && now.isBefore(end);
  }

  @override
  Widget build(BuildContext context) {
    final eventDetail = ref.watch(eventDetailProvider(widget.eventId!));

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      floatingActionButton: eventDetail.when(
        data: (event) {
          final enabled = isWithinEventTime(event);

          return ButtonFoatingCard(
            onPressed: enabled
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body: MobileScanner(
                            overlayBuilder: (context, constraints) {
                              return QrScannerOverlay(
                                onCancel: () => Navigator.pop(context),
                              );
                            },
                            onDetect: (result) {
                              debugPrint(result.barcodes.first.rawValue);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    );
                  }
                : null, // désactive le bouton si hors horaire
            icon: Icons.qr_code_rounded,
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (_, _) => const SizedBox.shrink(),
      ),

      body: eventDetail.when(
        data: (event) => EventDetailBody(event: event),
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
