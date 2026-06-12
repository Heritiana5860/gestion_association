import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CardExportService {
  /// Capture un widget entouré d'un RepaintBoundary en PNG.
  static Future<Uint8List?> captureAsPng(
    GlobalKey key, {
    double pixelRatio = 3.0,
  }) async {
    try {
      final boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Erreur capture carte: $e');
      return null;
    }
  }

  /// Convertit un PNG en JPG.
  static Uint8List? pngToJpg(Uint8List pngBytes, {int quality = 92}) {
    final image = img.decodeImage(pngBytes);
    if (image == null) return null;
    return Uint8List.fromList(img.encodeJpg(image, quality: quality));
  }

  /// Sauvegarde des bytes dans un fichier (png/jpg).
  static Future<String> saveBytesToFile(
    Uint8List bytes,
    String fileName,
    String extension,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName.$extension');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  /// Génère un PDF contenant une carte par page (format carte standard CR80).
  static Future<Uint8List> generatePdfBytes(List<Uint8List> images) {
    final pdf = pw.Document();

    // Format carte de membre (85.6mm x 54mm), avec une petite marge.
    const cardFormat = PdfPageFormat(
      85.6 * PdfPageFormat.mm,
      54 * PdfPageFormat.mm,
      marginAll: 0,
    );

    for (final bytes in images) {
      final memImage = pw.MemoryImage(bytes);
      pdf.addPage(
        pw.Page(
          pageFormat: cardFormat,
          build: (context) => pw.Image(memImage, fit: pw.BoxFit.cover),
        ),
      );
    }

    return pdf.save();
  }

  /// Sauvegarde un PDF sur disque.
  static Future<String> savePdfToFile(
    Uint8List pdfBytes,
    String fileName,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName.pdf');
    await file.writeAsBytes(pdfBytes);
    return file.path;
  }

  /// Ouvre directement la boîte de dialogue d'impression avec le PDF.
  static Future<void> printPdf(
    Uint8List pdfBytes, {
    String name = 'carte_membre',
  }) async {
    await Printing.layoutPdf(name: name, onLayout: (format) => pdfBytes);
  }
}
