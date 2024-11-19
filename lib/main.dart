import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  final body = Center( // ボディー
    child: PdfPreview(// プレビューの表示
      build: (format) async {
        final pdf = await makePdf();
        // .save()で「Uint8List」形式の作成
        return await pdf.save();
      },),
  );  

  final sc = Scaffold(
    body: body, // ボディー        
  );

  final app = MaterialApp(home: sc);
  runApp(app);
}

// PDF作成
Future makePdf() async {
  final pdf = pw.Document();
  final page = pw.Page(
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Text("PDF Test"),
      ); // Center
    }
  );

  pdf.addPage(page); 

  return pdf;
}