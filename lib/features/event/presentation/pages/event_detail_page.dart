import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_detail_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_provider.dart';
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
  bool _isProcessing = false;

  bool isWithinEventTime(EventEntity event) {
    final now = DateTime.now().toUtc(); // ← forcer UTC
    final start = DateTime.parse(event.startTime).toUtc();
    final end = DateTime.parse(event.endTime).toUtc();

    return now.isAfter(start) && now.isBefore(end);
  }

  Future<void> _handleDetect(
    BarcodeCapture result,
    BuildContext scannerContext,
  ) async {
    if (_isProcessing) return;

    final code = result.barcodes.first.rawValue;
    if (code == null) return;

    setState(() => _isProcessing = true);

    final usecase = ref.read(usecaseEventProvider);
    final res = await usecase.callAddComingMember(
      eventId: widget.eventId!,
      memberCde: code,
    );

    if (!mounted) return;

    if (scannerContext.mounted) {
      Navigator.of(scannerContext).pop();
    }

    res.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: AppColor.red,
          ),
        );
      },
      (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.green),
        );
        ref.invalidate(eventDetailProvider(widget.eventId!));
      },
    );

    setState(() => _isProcessing = false);
  }

  @override
  Widget build(BuildContext context) {
    final eventDetail = ref.watch(eventDetailProvider(widget.eventId!));

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      floatingActionButton: eventDetail.when(
        data: (event) {
          final enabled = isWithinEventTime(event);

          return enabled
              ? ButtonFoatingCard(
                  heroTag: "event-detail-btn",
                  onPressed: () {
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
                            onDetect: (result) =>
                                _handleDetect(result, context),
                          ),
                        ),
                      ),
                    );
                  }, // désactive le bouton si hors horaire
                  icon: Icons.qr_code_rounded,
                )
              : null;
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
