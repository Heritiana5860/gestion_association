import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/pdf_viewer_page.dart';

class Campus extends StatelessWidget {
  const Campus({super.key});

  @override
  Widget build(BuildContext context) {
    return const PdfViewerPage(
      assetPath: 'assets/data/campus.pdf',
      title: "Fitsipi-pitantanana anatiny momba ny tranon'ny fikambanana",
    );
  }
}
