// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Advice.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Chamber.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Doctor.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Investigation.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Medicine.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/NextPlan.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/OE.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Patient.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/chiefCompliant.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/qrcode.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/prescription.dart';
// import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class SfPdfPrescription {
  static Future<File> generate(Prescription prescription) async {
    final PdfDocument document = PdfDocument();
    document.pageSettings.size = PdfPageSize.a4;
    document.pageSettings.margins.all = 20;

    PdfPage pages = document.pages.add();

    final ttfFont = await rootBundle.load("assets/fonts/Shonar.ttf");
    ttfFont.buffer.asUint8List();
    //Read font data
    final Uint8List fontData = ttfFont.buffer.asUint8List();

    final PdfFont banglaFont = PdfTrueTypeFont(fontData, 14);

    buildHeader(banglaFont, document, prescription, pages);

    buildFooter(banglaFont, document, prescription.chamber);

    return saveFile(document);
  }

  static buildCustomerCard(
      PdfDocument document, Patient patient, PdfPage pages) {
    pages.graphics.drawString(
      'Name: ',
      PdfStandardFont(PdfFontFamily.timesRoman, 13, style: PdfFontStyle.bold),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(5, 135, 240, 50),
    );
    pages.graphics.drawString(
      'Thana: ',
      PdfStandardFont(PdfFontFamily.timesRoman, 13, style: PdfFontStyle.bold),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(5, 150, 240, 50),
    );
    pages.graphics.drawString(
      'Date: ',
      PdfStandardFont(PdfFontFamily.timesRoman, 13, style: PdfFontStyle.bold),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(5, 165, 240, 50),
    );
    pages.graphics.drawString(
      patient.name ?? '',
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(58, 135, 240, 50),
    );
    pages.graphics.drawString(
      patient.thana ?? '',
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(58, 150, 240, 50),
    );
    pages.graphics.drawString(
      patient.date ?? '',
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(58, 165, 240, 50),
    );
    pages.graphics.drawString(
      "Age:",
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(245, 135, 90, 50),
    );
    pages.graphics.drawString(
      "Dist:",
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(245, 150, 90, 50),
    );
    pages.graphics.drawString(
      "ID:",
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(245, 165, 90, 50),
    );
    pages.graphics.drawString(
      '${patient.age ?? '0'} Yrs',
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(273, 135, 90, 50),
    );
    pages.graphics.drawString(
      '${patient.dist!}',
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(273, 150, 90, 50),
    );
    pages.graphics.drawString(
      patient.id ?? '0',
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(273, 165, 90, 50),
    );
    pages.graphics.drawString(
      "Sex:",
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(373, 135, 210, 50),
    );
    pages.graphics.drawString(
      "Mob:",
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(373, 150, 210, 50),
    );
    pages.graphics.drawString(
      "Referred By:",
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(373, 165, 210, 50),
    );
    pages.graphics.drawString(
      patient.gender ?? '',
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(400, 135, 210, 50),
    );
    pages.graphics.drawString(
      patient.mobile ?? '',
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(410, 150, 210, 50),
    );
    pages.graphics.drawString(
      patient.referredBy ?? '',
      PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(445, 165, 210, 50),
    );
  }

  static buildFooter(PdfFont font, PdfDocument document, Chamber chamber) {
    //Create a footer template and draw a text.
    final PdfPageTemplateElement footerElement =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 70));
    footerElement.graphics.drawString(
      // 'চেম্বারঃ ${chamber.chamber1Bangla ?? ''}',
      'Chamber: ',

      // font,
      PdfStandardFont(PdfFontFamily.timesRoman, 10, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(0, 22, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    footerElement.graphics.drawString(
      // 'চেম্বারঃ ${chamber.chamber1Bangla ?? ''}',
      '${chamber.chamber1Bangla ?? ""}',

      // font,
      PdfStandardFont(PdfFontFamily.timesRoman, 10,
          style: PdfFontStyle.regular),
      bounds: const Rect.fromLTWH(48, 22, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    footerElement.graphics.drawString(
      'Consultation Days: ',
      // 'রোগী দেখার দিন  ${chamber.chamber1ConsultDayBangla ?? ''}',
      // font,
      PdfStandardFont(PdfFontFamily.timesRoman, 10, style: PdfFontStyle.bold),

      bounds: const Rect.fromLTWH(0, 45, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    footerElement.graphics.drawString(
      '${chamber.chamber1ConsultDayBangla ?? ''}',
      // 'রোগী দেখার দিন  ${chamber.chamber1ConsultDayBangla ?? ''}',
      // font,
      PdfStandardFont(PdfFontFamily.timesRoman, 10,
          style: PdfFontStyle.regular),

      bounds: const Rect.fromLTWH(85, 45, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    footerElement.graphics.drawString(
      // 'রোগী দেখার সময়ঃ  ${chamber.chamber1ConsultTimeBangla ?? ''}',
      'Consultation Time: ',
      PdfStandardFont(PdfFontFamily.timesRoman, 10, style: PdfFontStyle.bold),
      // font,
      bounds: const Rect.fromLTWH(0, 58, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    footerElement.graphics.drawString(
      // 'রোগী দেখার সময়ঃ  ${chamber.chamber1ConsultTimeBangla ?? ''}',
      '${chamber.chamber1ConsultTimeBangla ?? ''}',
      PdfStandardFont(PdfFontFamily.timesRoman, 10,
          style: PdfFontStyle.regular),
      // font,
      bounds: const Rect.fromLTWH(86, 58, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    footerElement.graphics.drawString(
      // 'চেম্বারঃ ${chamber.chamber1Bangla ?? ''}',
      'Chamber: ',

      // font,
      PdfStandardFont(PdfFontFamily.timesRoman, 10, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(255, 22, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    footerElement.graphics.drawString(
      // 'চেম্বারঃ ${chamber.chamber1Bangla ?? ''}',
      '${chamber.chamber2Bangla ?? ""}',

      // font,
      PdfStandardFont(PdfFontFamily.timesRoman, 10,
          style: PdfFontStyle.regular),
      bounds: const Rect.fromLTWH(305, 22, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    footerElement.graphics.drawString(
      'Consultation Days: ',
      // 'রোগী দেখার দিন  ${chamber.chamber1ConsultDayBangla ?? ''}',
      // font,
      PdfStandardFont(PdfFontFamily.timesRoman, 10, style: PdfFontStyle.bold),

      bounds: const Rect.fromLTWH(255, 45, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    footerElement.graphics.drawString(
      '${chamber.chamber2ConsultDayBangla ?? ''}',
      // 'রোগী দেখার দিন  ${chamber.chamber1ConsultDayBangla ?? ''}',
      // font,
      PdfStandardFont(PdfFontFamily.timesRoman, 10,
          style: PdfFontStyle.regular),

      bounds: const Rect.fromLTWH(345, 45, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    footerElement.graphics.drawString(
      // 'রোগী দেখার সময়ঃ  ${chamber.chamber1ConsultTimeBangla ?? ''}',
      'Consultation Time: ',
      PdfStandardFont(PdfFontFamily.timesRoman, 10, style: PdfFontStyle.bold),
      // font,
      bounds: const Rect.fromLTWH(255, 58, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    footerElement.graphics.drawString(
      // 'রোগী দেখার সময়ঃ  ${chamber.chamber1ConsultTimeBangla ?? ''}',
      '${chamber.chamber2ConsultTimeBangla ?? ''}',
      PdfStandardFont(PdfFontFamily.timesRoman, 10,
          style: PdfFontStyle.regular),
      // font,
      bounds: const Rect.fromLTWH(345, 58, 250, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    footerElement.graphics.drawString(
      'ডাক্তারের পরামর্শ ব্যাতিত কোনো ওষুধ পরিবর্তন বা বন্ধ করবেন না।',
      font,
      bounds: const Rect.fromLTWH(0, 3, 515, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    // footerElement.graphics.setTransparency(0.6);
    // PdfCompositeField(text: 'Page {0} of {1}', fields: <PdfAutomaticField>[
    //   PdfPageNumberField(brush: PdfBrushes.black),
    //   PdfPageCountField(brush: PdfBrushes.black)
    // ]).draw(footerElement.graphics, const Offset(450, 35));

    footerElement.graphics
        .drawLine(PdfPens.gray, const Offset(0, 8), const Offset(80, 8));
    footerElement.graphics
        .drawLine(PdfPens.gray, const Offset(440, 8), const Offset(515, 8));
    footerElement.graphics
        .drawLine(PdfPens.gray, const Offset(80, 20), const Offset(80, 0));
    footerElement.graphics
        .drawLine(PdfPens.gray, const Offset(440, 20), const Offset(440, 0));
    footerElement.graphics
        .drawLine(PdfPens.gray, const Offset(80, 0), const Offset(440, 0));
    footerElement.graphics
        .drawLine(PdfPens.gray, const Offset(80, 20), const Offset(440, 20));

    document.template.bottom = footerElement;
  }

  static buildHeader(PdfFont font, PdfDocument document,
      Prescription prescription, PdfPage pages) {
    //Create a header template and draw image/text.
    final PdfPageTemplateElement headerElement =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 720));
    buildLeftSide(headerElement, font, prescription.doctor, pages);

    // buildQRCode(prescription.qrCode, headerElement, pages);
    // headerElement.graphics.setTransparency(0.6);
    buildRightSide(headerElement, prescription.doctor, pages);

    headerElement.graphics
        .drawLine(PdfPens.gray, const Offset(0, 134), const Offset(515, 134));

    buildCustomerCard(document, prescription.patient, pages);

    headerElement.graphics
        .drawLine(PdfPens.gray, const Offset(0, 190), const Offset(515, 190));

    headerElement.graphics
        .drawLine(PdfPens.gray, const Offset(170, 200), const Offset(170, 720));
    document.template.top = headerElement;

    buildLeftPrescription(prescription, document, headerElement, pages, font);
    buildRightPrescription(prescription, document, headerElement, pages, font);
  }

  static buildQRCode(
      QrCode qrCode, PdfPageTemplateElement headerElement, PdfPage pages) {
    headerElement.graphics.drawRectangle(
        brush: PdfBrushes.chocolate,
        bounds: Rect.fromLTWH(
          227,
          0,
          60,
          60,
        ));
    // headerElement.graphics.

    // PdfQRBarcode barcode = new PdfQRBarcode();
  }

  static buildRightPrescription(Prescription prescription, PdfDocument document,
      PdfPageTemplateElement headerElement, PdfPage pages, PdfFont font) {
    buildRx(headerElement, pages);
    buildMedicineList(
        prescription.medicine, document, headerElement, pages, font);
    buildNextPlan(prescription.nextPlan, headerElement, pages, font);
    buildSignature(headerElement, pages);
  }

  static buildMedicineList(Medicine medicine, PdfDocument document,
      PdfPageTemplateElement headerElement, PdfPage pages, PdfFont font) {
    PdfUnorderedList(
            // text: 'Mammals\nReptiles\nBirds\nInsects\nAquatic Animals',
            style: PdfUnorderedMarkerStyle.circle,
            items: PdfListItemCollection(medicine.medicine!),
            font: font,
            indent: 10,
            textIndent: 3,
            format: PdfStringFormat(lineSpacing: 5))
        .draw(page: pages, bounds: Rect.fromLTWH(220, 200, 350, 0));
  }

  static buildRx(
    PdfPageTemplateElement headerElement,
    PdfPage pages,
  ) {
    headerElement.graphics.drawString(
      "R",
      PdfStandardFont(PdfFontFamily.helvetica, 25, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(175, 195, 200, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    headerElement.graphics.drawString(
      "x",
      PdfStandardFont(PdfFontFamily.helvetica, 17),
      bounds: const Rect.fromLTWH(193, 212, 200, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
  }

  static buildSignature(PdfPageTemplateElement headerElement, PdfPage pages) {
    headerElement.graphics.drawString(
      "Signature",
      PdfStandardFont(PdfFontFamily.timesRoman, 14, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(320, 703, 200, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    headerElement.graphics
        .drawLine(PdfPens.gray, const Offset(300, 700), const Offset(400, 700));
  }

  static buildNextPlan(NextPlan nextPlan, PdfPageTemplateElement headerElement,
      PdfPage pages, PdfFont font) {
    pages.graphics.drawString(
      "Next Plan: ",
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(230, 640, 400, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    pages.graphics.drawString(
      "Come back again after ${nextPlan.nextPlan![0]}",
      PdfStandardFont(PdfFontFamily.timesRoman, 12),
      bounds: const Rect.fromLTWH(290, 640, 400, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    // PdfUnorderedList(
    //         // text: 'Mammals\nReptiles\nBirds\nInsects\nAquatic Animals',
    //         style: PdfUnorderedMarkerStyle.none,
    //         items: PdfListItemCollection(nextPlan.nextPlan),
    //         font: font,
    //         indent: 10,
    //         textIndent: 3,
    //         format: PdfStringFormat(lineSpacing: 0))
    //     .draw(page: pages, bounds: Rect.fromLTWH(277, 640, 250, 0));
  }

  static buildLeftPrescription(Prescription prescription, PdfDocument document,
      PdfPageTemplateElement headerElement, PdfPage pages, PdfFont font) {
    buildCC(prescription.cc, headerElement, pages);
    buildOE(prescription.oe, headerElement, pages);
    buildInvestigation(prescription.investigation, headerElement, pages);
    buildAdvices(prescription.advice, headerElement, pages, font);
  }

  static buildCC(
      ChiefCompliant cc, PdfPageTemplateElement headerElement, PdfPage pages) {
    pages.graphics.drawString(
      "C/C",
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(0, 195, 170, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    PdfUnorderedList(
            // text: 'Mammals\nReptiles\nBirds\nInsects\nAquatic Animals',
            style: PdfUnorderedMarkerStyle.circle,
            items: PdfListItemCollection(cc.cc!),
            font: PdfStandardFont(PdfFontFamily.timesRoman, 11),
            indent: 10,
            textIndent: 3,
            format: PdfStringFormat(lineSpacing: 0))
        .draw(page: pages, bounds: Rect.fromLTWH(0, 212, 170, 0));
  }

  static buildOE(OE oe, PdfPageTemplateElement headerElement, PdfPage pages) {
    pages.graphics.drawString(
      "O/E",
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(0, 340, 170, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    PdfUnorderedList(
            style: PdfUnorderedMarkerStyle.circle,
            items: PdfListItemCollection(oe.oe!),
            font: PdfStandardFont(PdfFontFamily.timesRoman, 11),
            indent: 10,
            textIndent: 3,
            format: PdfStringFormat(lineSpacing: 0))
        .draw(page: pages, bounds: Rect.fromLTWH(0, 360, 170, 0));
  }

  static buildInvestigation(Investigation investigation,
      PdfPageTemplateElement headerElement, PdfPage pages) {
    pages.graphics.drawString(
      "Investigation",
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(0, 470, 170, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    PdfUnorderedList(
            style: PdfUnorderedMarkerStyle.circle,
            items: PdfListItemCollection(investigation.investigation!),
            font: PdfStandardFont(PdfFontFamily.timesRoman, 11),
            indent: 10,
            textIndent: 3,
            format: PdfStringFormat(lineSpacing: 0))
        .draw(page: pages, bounds: Rect.fromLTWH(0, 490, 170, 0));
  }

  static buildAdvices(Advice advice, PdfPageTemplateElement headerElement,
      PdfPage pages, PdfFont font) async {
    final ttfFont = await rootBundle.load("assets/fonts/Shonarb.ttf");
    ttfFont.buffer.asUint8List();
    final Uint8List fontData = ttfFont.buffer.asUint8List();
    final PdfFont banglaFont = PdfTrueTypeFont(
      fontData,
      14,
      style: PdfFontStyle.bold,
    );

    pages.graphics.drawString(
      "উপদেশ",
      banglaFont,
      bounds: const Rect.fromLTWH(0, 590, 170, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    PdfUnorderedList(
            style: PdfUnorderedMarkerStyle.circle,
            items: PdfListItemCollection(advice.advices!),
            font: font,
            indent: 10,
            textIndent: 3,
            format: PdfStringFormat(lineSpacing: 2))
        .draw(page: pages, bounds: Rect.fromLTWH(0, 610, 170, 0));
  }

  static buildRightSide(
      PdfPageTemplateElement headerElement, Doctor doctor, PdfPage pages) {
    headerElement.graphics.drawString(
      doctor.docorNameEnglish!,
      PdfStandardFont(PdfFontFamily.timesRoman, 20, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(280, -2, 235, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.right,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    headerElement.graphics.drawString(
      doctor.doctorDegree1English!,
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.italic),
      bounds: const Rect.fromLTWH(280, 30, 235, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.right,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    headerElement.graphics.drawString(
      doctor.doctorDegree2English!,
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.italic),
      bounds: const Rect.fromLTWH(280, 45, 235, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.right,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    headerElement.graphics.drawString(
      doctor.doctorDesignation1English!,
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.italic),
      bounds: const Rect.fromLTWH(280, 60, 235, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.right,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    headerElement.graphics.drawString(
      doctor.doctorDesignation2English!,
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.italic),
      bounds: const Rect.fromLTWH(280, 75, 235, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.right,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );
    headerElement.graphics.drawString(
      doctor.doctorWorkplace1English!,
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.italic),
      bounds: const Rect.fromLTWH(280, 90, 235, 50),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.right,
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    // PdfOrderedList(
    //     items: PdfListItemCollection(<String>[
    //       doctor.doctorDegree1English!,
    //       doctor.doctorDegree2English!,
    //       doctor.doctorDesignation1English!,
    //       doctor.doctorDesignation2English!,
    //       doctor.doctorWorkplace1English!,
    //     ]),
    //     marker: PdfOrderedMarker(style: PdfNumberStyle.none),
    //     font: PdfStandardFont(PdfFontFamily.timesRoman, 12,
    //         style: PdfFontStyle.regular),
    //     indent: 0,
    //     format: PdfStringFormat(
    //       lineSpacing: 0,
    //       alignment: PdfTextAlignment.right,
    //     )).draw(page: pages, bounds: Rect.fromLTWH(305, 40, 250, 0));
  }

  static buildLeftSide(PdfPageTemplateElement headerElement, PdfFont font,
      Doctor doctor, PdfPage pages) async {
    final ttfFont = await rootBundle.load("assets/fonts/Shonarb.ttf");
    ttfFont.buffer.asUint8List();
    final Uint8List fontData = ttfFont.buffer.asUint8List();
    final PdfFont banglaFont = PdfTrueTypeFont(
      fontData,
      20,
      style: PdfFontStyle.bold,
    );
    final PdfFont italicBanglaFont = PdfTrueTypeFont(
      fontData,
      12,
      style: PdfFontStyle.italic,
    );

    headerElement.graphics.drawString(
      doctor.doctorNameBangla!,
      // banglaFont,
      PdfStandardFont(PdfFontFamily.timesRoman, 20, style: PdfFontStyle.italic),
      bounds: const Rect.fromLTWH(2, 0, 280, 50),
      format: PdfStringFormat(
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    headerElement.graphics.drawString(
      doctor.doctorDegree1Bangla!,
      // italicBanglaFont,
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.italic),

      bounds: const Rect.fromLTWH(2, 30, 235, 50),
      format: PdfStringFormat(
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    headerElement.graphics.drawString(
      doctor.doctorDegree2Bangla!,
      // italicBanglaFont,
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.italic),
      bounds: const Rect.fromLTWH(2, 45, 235, 50),
      format: PdfStringFormat(
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    headerElement.graphics.drawString(
      doctor.doctorDesignation1Bangla!,
      // italicBanglaFont,
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.italic),
      bounds: const Rect.fromLTWH(2, 60, 235, 50),
      format: PdfStringFormat(
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    headerElement.graphics.drawString(
      doctor.doctorDesignation2Bangla!,
      // italicBanglaFont,
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.italic),
      bounds: const Rect.fromLTWH(2, 75, 235, 50),
      format: PdfStringFormat(
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    headerElement.graphics.drawString(
      doctor.doctorWorkplace1Bangla!,
      // italicBanglaFont,
      PdfStandardFont(PdfFontFamily.timesRoman, 12, style: PdfFontStyle.italic),
      bounds: const Rect.fromLTWH(2, 90, 235, 50),
      format: PdfStringFormat(
        lineAlignment: PdfVerticalAlignment.top,
      ),
    );

    // PdfOrderedList(
    //     items: PdfListItemCollection(<String>[
    //       doctor.doctorDegree1Bangla!,
    //       doctor.doctorDegree2Bangla!,
    //       doctor.doctorDesignation1Bangla!,
    //       doctor.doctorDesignation2Bangla!,
    //       doctor.doctorWorkplace1Bangla!,
    //     ]),
    //     marker: PdfOrderedMarker(style: PdfNumberStyle.none),
    //     font: font,
    //     indent: 0,
    //     format: PdfStringFormat(
    //       lineSpacing: 0,
    //       alignment: PdfTextAlignment.left,
    //     )).draw(page: pages, bounds: Rect.fromLTWH(0, 40, 250, 0));
  }

  static Future<File> saveFile(PdfDocument document) async {
    final path = await getApplicationDocumentsDirectory();
    final fileName =
        path.path + '/prescription-${DateTime.now().toIso8601String()}.pdf';
    final file = File(fileName);
    file.writeAsBytes(document.save());
    document.dispose();
    return file;
  }
}
