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
  final pdf = pw.Document();
  
  final page = pw.Page(
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Text("PDF Test"),
      ); // Center
    }
  );

  List<pw.TableRow> tablerowList = [];
  for(int i = 1; i <= 100; i++) {
    tablerowList.add(
      pw.TableRow(
        children: [ pw.Text('Test$i'), pw.Text('$i') ,],
      )
    );
  }

  final table = pw.Table( // Tableウィジェット
    border: pw.TableBorder.all(),
    children: tablerowList,
  );

  final pageM = pw.MultiPage( // MultiPageウィジェット
    build: (pw.Context context) {
      return [ table, ]; // Center
    }
  );

  pdf.addPage(page); 
  pdf.addPage(pageM); // マルチページ

  return pdf;
}