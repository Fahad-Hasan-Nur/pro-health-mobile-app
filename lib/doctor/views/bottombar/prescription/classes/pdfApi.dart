import 'dart:io';

// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:pdf/widgets.dart';
import 'package:share/share.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    // final url = file.path;

    // await OpenFile.open(url);
  }

  static Future<File> loadNetwork(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes, fileName);
  }

  static Future<File> _storeFile(
      String url, List<int> bytes, String fileName) async {
    final dir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    File file = File("${dir!.path}/$fileName.pdf");
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsBytes(bytes, flush: true);
    }

    return file;
  }

  static Future shareFile(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    final dir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    File file = File("${dir!.path}/$fileName.pdf");
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsBytes(bytes, flush: true);
    }

    Share.shareFiles([file.path], subject: 'prescription');
  }
}
