import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'controller.dart';

Future<void> generatePDF(HistoryViewController controller) async {
  final doc = pw.Document();
  final directory = await getDownloadsDirectory();
  String path = '${directory!.path}/example.pdf';

  List<pw.Widget> widgets = [];

  controller.state.value = InfoStateHistoryView.loading;

  for (int i = 0; i < controller.dividedHistory.length; i++) {
    widgets.add(
        pw.Text(
            controller.dividedHistory[i], style: const pw.TextStyle(fontSize: 15)
        )
    );

    // Add images
    if (i < controller.image_urls.length) {

      final http.Response response = await http.get(
          Uri.parse(controller.image_urls[i]!),
          headers: {
            'Connection': 'Keep-Alive',
          },
      );
      if (response.statusCode == 200) {
        final Uint8List imageData = response.bodyBytes;
        final pw.ImageProvider image = pw.MemoryImage(imageData);
        widgets.add(pw.SizedBox(height: 5));
        widgets.add(pw.Image(image));
        widgets.add(pw.SizedBox(height: 5));
      } else {
        widgets.add(pw.Text('Failed to load image: ${controller.image_urls[i]}'));
      }
    }
  }

  controller.state.value = InfoStateHistoryView.success;

  final pdfWidgets = [
    pw.Center(child: pw.Text(controller.historyItem!.title, style: const pw.TextStyle(fontSize: 30))),
    pw.SizedBox(height: 50),
    ...widgets,
  ];

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pdfWidgets;
      }
    )
  );

  final file = File(path);
  await file.writeAsBytes(await doc.save());

  OpenFile.open(path);
}


