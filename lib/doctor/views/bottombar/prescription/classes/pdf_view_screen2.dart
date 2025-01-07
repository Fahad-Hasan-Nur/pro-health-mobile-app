import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen2 extends StatefulWidget {
  const PdfViewScreen2({Key? key, this.fileType, this.path, this.pdfFile})
      : super(key: key);
  final String? path;
  final pdfFile;
  final fileType;

  @override
  _PdfViewScreen2State createState() =>
      _PdfViewScreen2State(fileType: this.fileType);
}

class _PdfViewScreen2State extends State<PdfViewScreen2> {
  final fileType;
  _PdfViewScreen2State({this.fileType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription Preview'),
        centerTitle: true,
      ),
      body: Container(
        // child: SfPdfViewer.network('assets/document.pdf'),
        child: SfPdfViewer.file(
          widget.pdfFile,
        ),
      ),
    );
  }
}
