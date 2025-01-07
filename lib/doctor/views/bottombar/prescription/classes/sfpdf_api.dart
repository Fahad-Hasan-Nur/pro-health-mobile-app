import 'dart:io';
// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class SfPdfApi {
  static Future<File> saveDocument({
    required String name,
    required PdfDocument pdf,
  }) async {
    final bytes = pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    // final url = file.path;

    // await OpenFile.open(url);
  }
}
