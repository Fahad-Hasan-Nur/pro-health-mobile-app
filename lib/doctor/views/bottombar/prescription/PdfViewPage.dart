import 'package:flutter/material.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/service/prescription_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewPage extends StatefulWidget {
  const PdfViewPage(
      {Key? key,
      this.fileType,
      this.path,
      this.pdfFile,
      this.title,
      this.bmdcNo,
      this.memberId,
      this.doctorId})
      : super(key: key);
  final String? path;
  final pdfFile;
  final fileType;
  final title;
  final bmdcNo;
  final memberId;
  final doctorId;

  @override
  _PdfViewPageState createState() => _PdfViewPageState(fileType: this.fileType);
}

class _PdfViewPageState extends State<PdfViewPage> {
  final fileType;
  _PdfViewPageState({this.fileType});

  printPdf() async {
    // http.Response response = await http.get(Uri.parse(widget.path!));
    // var pdfData = response.bodyBytes;
    // await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
    var printed = await PrescriptionService().printPrescription(
      widget.path!,
      widget.doctorId,
      widget.memberId,
      widget.bmdcNo,
    );
    if (printed) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('prescription sent for printing')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription Preview'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              printPdf();
            },
            icon: Icon(
              Icons.print,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Container(
        // child: SfPdfViewer.network('assets/document.pdf'),
        child: SfPdfViewer.file(
          widget.pdfFile,
        ),
        // child: SfPdfViewer.network(widget.path!),
      ),
    );
  }
}
