import 'package:flutter/material.dart';
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
  
  // フォントの取得
  final font = await PdfGoogleFonts.shipporiMinchoRegular();

  final pdf = pw.Document();
  final page = pw.Page(
    pageTheme: pw.PageTheme(
      theme: pw.ThemeData.withFont(base: font), // フォントを設定
    ),
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Text("テキスト"),
      ); // Center
    }
  ); 
  pdf.addPage(page); 
  return pdf;
}