import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';

class PdfViewerPage extends StatefulWidget {
  final String assetPath;
  final String title;

  const PdfViewerPage({
    super.key,
    required this.assetPath,
    required this.title,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String? _localPath;
  bool _isLoading = true;
  int _totalPages = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadPdfFromAssets();
  }

  Future<void> _loadPdfFromAssets() async {
    // Copie le PDF en mémoire temporaire (flutter_pdfview nécessite un File)
    final bytes = await rootBundle.load(widget.assetPath);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${widget.title}.pdf');
    await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);

    if (mounted) {
      setState(() {
        _localPath = file.path;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        title: AppText(label: widget.title, fontWeight: FontWeight.w600),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          if (!_isLoading)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: AppText(
                  label: "$_currentPage / $_totalPages",
                  fontSize: 12,
                  color: AppColor.textDescription,
                ),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: AppColor.blue))
          : PDFView(
              filePath: _localPath!,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              fitPolicy: FitPolicy.WIDTH,
              preventLinkNavigation: true, // bloque les liens externes
              onRender: (pages) {
                if (mounted) {
                  setState(() {
                    _totalPages = pages ?? 0;
                    _currentPage = 1;
                  });
                }
              },
              onPageChanged: (page, total) {
                if (mounted) {
                  setState(() => _currentPage = (page ?? 0) + 1);
                }
              },
              onError: (error) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColor.red,
                  content: AppText(
                    label: "PDF error: $error",
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
    );
  }
}
