import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/pdf_viewer_page.dart';

class ReglementPage extends StatelessWidget {
  const ReglementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PdfViewerPage(
      assetPath: 'assets/data/reglement.pdf',
      title: 'Règlement intérieur',
    );
  }
}
