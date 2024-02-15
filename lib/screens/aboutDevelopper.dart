import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class AboutDeveloper extends StatelessWidget {
  AboutDeveloper({super.key});

  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/mhdabdellahi_2023-2024_cv.pdf'),
  );

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: pdfController,
    );
  }
}
