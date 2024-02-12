import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class AboutDeveloper extends StatefulWidget {
  const AboutDeveloper({super.key});

  @override
  State<AboutDeveloper> createState() => _AboutDeveloperState();
}

class _AboutDeveloperState extends State<AboutDeveloper> {
  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/mhdabdellahi_2023-2024_cv.pdf'),
  );

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: pdfController,
    );

    // Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Center(
    //           child: Text(AppLocalizations.of(context)!
    //               .someInformationsAboutTheDevelopper)),
    //     ),
    //     PdfView(
    //       controller: pdfController,
    //     ),
    //   ],
    // );
  }
}
