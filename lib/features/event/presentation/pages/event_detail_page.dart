import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/provider_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/ref_listen_error.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_circular.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/button_foating_card.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_detail_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_submit_notifier.dart';
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
  final MobileScannerController _scannerController = MobileScannerController();

  late final ProviderSubscription<AsyncValue<void>> _eventSubscription;

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

    _isProcessing = true; // set AVANT tout await, sans passer par setState
    await _scannerController
        .stop(); // stoppe immédiatement la caméra, plus de détections possibles

    try {
      await ref
          .read(newEventProvider.notifier)
          .comingMember(eventId: widget.eventId!, memberCde: code);

      if (!mounted) return;

      final isSuccess = ref.read(newEventProvider) is AsyncData;

      if (isSuccess && scannerContext.mounted) {
        Navigator.of(scannerContext).pop();
      } else {
        await _scannerController.start(); // relance le scan si échec
        _isProcessing = false;
      }
    } catch (_) {
      if (mounted) {
        await _scannerController.start();
        _isProcessing = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _eventSubscription = ref.listenManual(newEventProvider, (previous, next) {
      next.whenOrNull(
        data: (_) async {
          debugPrint(
            '[SCAN] invalidate eventDetailProvider(${widget.eventId})',
          );
          ref.invalidate(eventDetailProvider(widget.eventId!));

          // Attendre le nouveau résultat et logger
          final refreshed = await ref.read(
            eventDetailProvider(widget.eventId!).future,
          );
          debugPrint(
            '[SCAN] membres après refresh: ${refreshed.members?.length}',
          );

          await ref.read(eventProvider.notifier).refresh();

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppText(label: "Présent(e)", color: AppColor.white),
                backgroundColor: AppColor.green,
              ),
            );
          }
        },
        error: (error, _) {
          RefListenError.errorListenProvider(context: context, error: error);
        },
      );
    });
  }

  @override
  void dispose() {
    _eventSubscription.close();
    super.dispose();
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
                            controller: _scannerController,
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
        loading: () => const AppCircular(),
        error: (error, _) => errorProvider(context: context, error: error),
      ),
    );
  }
}
