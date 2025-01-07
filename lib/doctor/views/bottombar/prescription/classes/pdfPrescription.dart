import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Chamber.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/OE.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Patient.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/chiefCompliant.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/pdfApi.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/prescription.dart';

class PdfPrescription {
  static Future<File> generate(Prescription prescription) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(25),
      build: (context) => [
        buildHeader(prescription),
        // SizedBox(height: 3 * PdfPageFormat.cm),
        Divider(),
        buildPatientCard(prescription.patient),
        Divider(),
        buildBody(prescription),
        // buildTotal(invoice),
      ],
      footer: (context) => buildFooter(prescription.chamber),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildBody(Prescription prescription) => Container(
        child: pw.Row(
          children: [
            buildLeftSide(prescription),
            buildRightSide(prescription),
          ],
        ),
      );

  static Widget buildCC(ChiefCompliant chiefCompliant) {
    final headers = [
      'C/C',
      "",
    ];
    final data = chiefCompliant.cc!.map((item) {
      return [
        '-',
        '$item',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      // border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      // headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 0,
      cellAlignments: {
        0: Alignment.centerRight,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
      },
    );
  }

  static Widget buildOE(OE oe) {
    final headers = [
      'O/E',
    ];
    final data = oe.oe!.map((item) {
      return [
        '-',
        '$item',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      cellPadding: EdgeInsets.all(0),

      // border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      // headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 0,
      cellAlignments: {
        0: Alignment.centerRight,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
      },
    );
  }

  static Widget buildLeftSide(Prescription prescription) {
    return pw.Container(
      width: 180,
      child: pw.Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pw.Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCC(prescription.cc),
              buildOE(prescription.oe),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildRightSide(Prescription prescription) {
    return pw.Container(
      width: 180,
      child: pw.Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pw.Column(
            children: [
              pw.Text('C/C'),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Chamber chamber) => Container(
        child: pw.Column(
          children: [
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pw.Text('Chamber: ',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                pw.Text(chamber.chamber1English!,
                    style: TextStyle(fontSize: 10)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pw.Text('Consultation Days: ',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                pw.Text(chamber.chamber1ConsultDayEnglish!,
                    style: TextStyle(fontSize: 10)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pw.Text('Consultation Time: ',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                pw.Text(chamber.chamber1ConsultTimeEnglish!,
                    style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      );

  static Widget buildPatientCard(Patient patient) => Container(
        child: pw.Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            pw.Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    pw.Text(
                      "Name: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    pw.Text(patient.name!, style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    pw.Text(
                      "Thana: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    pw.Text(patient.thana!, style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    pw.Text(
                      "Date: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    pw.Text(patient.date!, style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    pw.Text(
                      "Age: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    pw.Text(patient.age!, style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    pw.Text(
                      "Dist: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    pw.Text(patient.dist!, style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    pw.Text(
                      "Id: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    pw.Text(patient.id!, style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    pw.Text(
                      "Sex: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    pw.Text(patient.gender!, style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    pw.Text(
                      "Mobile: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    pw.Text(patient.mobile!, style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    pw.Text(
                      "Referred By: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    pw.Text(patient.referredBy!,
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  static Widget buildHeader(Prescription prescription) => Column(
        children: [
          pw.Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                width: 250,
                child: pw.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pw.Text(prescription.doctor.docorNameEnglish!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    pw.Text(prescription.doctor.doctorDegree1English!,
                        style: TextStyle(fontSize: 10)),
                    pw.Text(prescription.doctor.doctorDegree2English!,
                        style: TextStyle(fontSize: 10)),
                    pw.Text(prescription.doctor.doctorDesignation1English!,
                        style: TextStyle(fontSize: 10)),
                    pw.Text(prescription.doctor.doctorDesignation2English!,
                        style: TextStyle(fontSize: 10)),
                    pw.Text(prescription.doctor.doctorWorkplace1English!,
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              pw.Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(barcode: Barcode.qrCode(), data: '123456'),
              ),
              pw.Container(
                width: 250,
                child: pw.Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    pw.Text(prescription.doctor.docorNameEnglish!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    pw.Text(prescription.doctor.doctorDegree1English!,
                        style: TextStyle(fontSize: 10)),
                    pw.Text(prescription.doctor.doctorDegree2English!,
                        style: TextStyle(fontSize: 10)),
                    pw.Text(prescription.doctor.doctorDesignation1English!,
                        style: TextStyle(fontSize: 10)),
                    pw.Text(prescription.doctor.doctorDesignation2English!,
                        style: TextStyle(fontSize: 10)),
                    pw.Text(prescription.doctor.doctorWorkplace1English!,
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.right),
                  ],
                ),
              ),
            ],
          ),
          pw.Row(),
        ],
      );
}
