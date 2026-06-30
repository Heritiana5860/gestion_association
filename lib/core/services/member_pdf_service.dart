import 'package:flutter/services.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_filters_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';

class MemberPdfService {
  static Future<Uint8List> generate({
    required List<MemberEntity> members,
    required String year,
    MemberFiltersModel? filters,
    String title = "Liste des membres",
  }) async {
    final doc = pw.Document();

    // Police custom si tu veux matcher ton identité visuelle
    // final font = pw.Font.ttf(
    //   await rootBundle.load("assets/fonts/Poppins-Regular.ttf"),
    // );

    final primaryColor = PdfColor.fromHex("#1F4FA8"); // adapte à ta charte AE7V
    final logoBytes = await rootBundle.load("assets/logo/logo.jpg");
    final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        header: (context) => _buildHeader(primaryColor, title, logoImage),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          pw.SizedBox(height: 12),
          _buildSummary(members.length, year, filters),
          pw.SizedBox(height: 12),
          _buildTable(members, primaryColor),
        ],
      ),
    );

    return doc.save();
  }

  static pw.Widget _buildHeader(
    PdfColor color,
    String title,
    pw.MemoryImage logo,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(logo, width: 40, height: 40),
            pw.SizedBox(width: 10),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Association des Étudiants 7 Vinagny",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: color,
                  ),
                ),
                pw.Text(
                  "Université de Fianarantsoa",
                  style: const pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
            pw.Text(
              "AE7V",
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Divider(color: color, thickness: 1.2),
        pw.SizedBox(height: 6),
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  static pw.Widget _buildFooter(pw.Context context) {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey400, thickness: 0.5),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              "Généré le ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
            ),
            pw.Text(
              "Page ${context.pageNumber}/${context.pagesCount}",
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSummary(
    int count,
    String year,
    MemberFiltersModel? f,
  ) {
    final activeFiltersText = _describeFilters(f);
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "Année : $year  |  Total : $count membre(s)",
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
          ),
          if (activeFiltersText.isNotEmpty)
            pw.Text(
              "Filtres appliqués : $activeFiltersText",
              style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
            ),
        ],
      ),
    );
  }

  static String _describeFilters(MemberFiltersModel? f) {
    if (f == null) return "";
    final parts = <String>[];
    if (f.search != null && f.search!.isNotEmpty) {
      parts.add('Recherche "${f.search}"');
    }
    if (f.statut != null && f.statut != "TOUS") {
      parts.add("Statut: ${f.statut}");
    }
    if (f.level != null && f.level != "TOUS") parts.add("Niveau: ${f.level}");
    if (f.isInside != null) parts.add(f.isInside! ? "Intérieur" : "Extérieur");
    return parts.join(" • ");
  }

  static pw.Widget _buildTable(List<MemberEntity> members, PdfColor color) {
    return pw.TableHelper.fromTextArray(
      headers: ["#", "Nom complet", "Téléphone", "Statut", "Adresse"],
      data: List.generate(members.length, (i) {
        final m = members[i];
        return ["${i + 1}", m.fullName, m.numberPhone, m.statut, m.address];
      }),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white,
        fontSize: 10,
      ),
      headerDecoration: pw.BoxDecoration(color: color),
      cellStyle: const pw.TextStyle(fontSize: 9),
      cellAlignment: pw.Alignment.centerLeft,
      cellPadding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey50),
      columnWidths: {
        0: const pw.FixedColumnWidth(25),
        1: const pw.FlexColumnWidth(3),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(1.5),
        4: const pw.FlexColumnWidth(2.5),
      },
    );
  }
}
