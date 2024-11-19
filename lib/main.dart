import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:flutter/services.dart'; // rootBundleで使用

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

Future makePdf() async { // PDF作成

  final fontData = await rootBundle.load('assets/fonts/ShipporiMincho-Regular.ttf');
  final font = pw.Font.ttf(fontData);

  final pdf = pw.Document();
  
  final page = pw.Page(
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Text("PDF Test"),
      ); // Center
    }
  );

  final page2 = pw.Page(
    pageTheme: pw.PageTheme( // ページのテーマ
      pageFormat: PdfPageFormat.a4, // ついでにA4にして見る
      theme: pw.ThemeData.withFont(base: font), // フォントを設定
    ),
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Text("テキスト"),
      ); // Center
    }
  ); 
  pdf.addPage(page); 
  pdf.addPage(page2); 
  return pdf;
}