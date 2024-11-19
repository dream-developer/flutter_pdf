import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {

    final buttonLayoutPdf = ElevatedButton(
      onPressed: () async{ 
        final pdf = await makePdf(); // 1
        await Printing.layoutPdf( // 2 
          onLayout: (_) async{
            return await pdf.save(); // 3
          },
        );
      },
      child: const Text("印刷"), 
    );
    
    final buttonSharePdf = ElevatedButton(
      onPressed: () async{ 
        final pdf = await makePdf();
        await Printing.sharePdf( // 4
          bytes: await pdf.save(),
          filename: 'test.pdf'
        ,);
      },
      child: const Text("他のアプリケーションと共有"), 
    );

  final body = SafeArea( // ボディー
    child: Column(
      children: [buttonLayoutPdf, buttonSharePdf, ],
    ),
  );  

  final sc = Scaffold( body: body,);
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
  pdf.addPage(page); 
  return pdf;
}