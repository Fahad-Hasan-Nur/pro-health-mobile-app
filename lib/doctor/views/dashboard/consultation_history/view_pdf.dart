import 'package:flutter/material.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/pdfApi.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/service/prescription_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdfOnline extends StatefulWidget {
  const ViewPdfOnline(
      {Key? key, this.path, this.bmdcNo, this.memberId, this.doctorId})
      : super(key: key);
  final String? path;

  final bmdcNo;
  final memberId;
  final doctorId;

  @override
  _ViewPdfOnlineState createState() => _ViewPdfOnlineState();
}

class _ViewPdfOnlineState extends State<ViewPdfOnline> {
  printPdf() async {
    await PdfApi.shareFile(widget.path!, 'prescription.pdf');
    // http.Response response = await http.get(Uri.parse(widget.path!));
    // var pdfData = response.bodyBytes;
    // await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
    // var printed = await PrescriptionService().printPrescription(
    //   widget.path!,
    //   widget.doctorId,
    //   widget.memberId,
    //   widget.bmdcNo,
    // );
    // if (printed) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('prescription sent for printing')));
    // }
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
              Icons.share,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Container(
        // child: SfPdfViewer.network('assets/document.pdf'),

        child: SfPdfViewer.network(widget.path!),
      ),
    );
  }
}
