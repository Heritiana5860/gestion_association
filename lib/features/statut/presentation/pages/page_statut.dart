import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/pdf_viewer_page.dart';

class PageStatut extends StatelessWidget {
  const PageStatut({super.key});

  @override
  Widget build(BuildContext context) {
    return const PdfViewerPage(
      assetPath: 'assets/data/statut.pdf',
      title: 'Statut',
    );
  }
}
