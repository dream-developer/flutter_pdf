import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';// PdfPageFormat
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
    body: body,);

  final app = MaterialApp(home: sc);
  runApp(app);
}

Future makePdf() async {
  // final pdf = pw.Document();
  final pdf = pw.Document(
    author: '作成者',
    creator: 'クリエイター',
    title: 'タイトル',
    subject:  'サブジェクト',
  );

  final page = pw.Page(
    pageTheme: pw.PageTheme(
      orientation:pw.PageOrientation.landscape, // 1
      pageFormat: PdfPageFormat.a4.copyWith( // 2
        marginTop: 20,
        marginBottom: 20,
        marginLeft: 20,
        marginRight: 20,
      ),
    ),
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Text("PDF Test"),
      ); // Center
    }
  ); 
  pdf.addPage(page); 
  return pdf;
}