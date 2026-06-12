import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/detail/scan/corner_painter.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/widgets/detail/scan/dark_overlay_with_hole.dart';

class QrScannerOverlay extends StatefulWidget {
  final VoidCallback? onCancel;

  const QrScannerOverlay({super.key, this.onCancel});

  @override
  State<QrScannerOverlay> createState() => _QrScannerOverlayState();
}

class _QrScannerOverlayState extends State<QrScannerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanController;
  late Animation<double> _scanAnimation;

  static const double frameWidth = 240;
  static const double frameHeight = 240;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanAnimation = CurvedAnimation(
      parent: _scanController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Colors.transparent,
            BlendMode.dst,
          ),
          child: Stack(
            children: [
              Container(color: Colors.black.withValues(alpha: 0.65)),
              Center(
                child: Container(
                  width: frameWidth,
                  height: frameHeight,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
        DarkOverlayWithHole(frameWidth: frameWidth, frameHeight: frameHeight),

        Center(
          child: SizedBox(
            width: frameWidth,
            height: frameHeight,
            child: CustomPaint(
              painter: CornerPainter(
                color: AppColor.blue, 
                strokeWidth: 3.5,
                cornerLength: 28,
              ),
            ),
          ),
        ),

        Center(
          child: SizedBox(
            width: frameWidth - 24,
            height: frameHeight,
            child: AnimatedBuilder(
              animation: _scanAnimation,
              builder: (context, _) {
                return Stack(
                  children: [
                    Positioned(
                      top: _scanAnimation.value * (frameHeight - 4),
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppColor.blue.withValues(alpha: 0.9),
                              Colors.transparent,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.blue.withValues(alpha: 0.5),
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),

        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.28,
          left: 0,
          right: 0,
          child: Column(
            children: [
              AppText(
                label: 'Placez le QR code dans le cadre',
                textAlign: TextAlign.center,
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
              const SizedBox(height: 6),
              AppText(
                label: 'La détection est automatique',
                textAlign: TextAlign.center,
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ],
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
              onPressed: widget.onCancel ?? () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded),
              color: Colors.white,
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
