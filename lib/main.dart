import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

import 'package:flutter/services.dart';

void main() {
  // 印刷ボタンと共有ボタンを作成
  final buttonLayoutPdf = ElevatedButton(
    onPressed: () async {
      final pdf = await makePdf();
      await Printing.layoutPdf(onLayout: (format) => pdf.save());
    },
    child: Text("印刷"),
  );

  final buttonSharePdf = ElevatedButton(
    onPressed: () async {
      final pdf = await makePdf();
      await Printing.sharePdf(bytes: await pdf.save());
    },
    child: Text("共有"),
  );

  final body = SafeArea(
    child: Column(
      children: [
        buttonLayoutPdf,
        buttonSharePdf,
      ],
    ),
  );

  final sc = Scaffold(body: body);
  final app = MaterialApp(home: sc);

  runApp(app);
}

// PDFドキュメントを生成する非同期関数
Future<pw.Document> makePdf() async {
  final font = await PdfGoogleFonts.shipporiMinchoRegular();

  // PDF Documentの作成
  final pdf = pw.Document(
    // メタデータを設定
    author: 'Author',
    creator: 'Creator',
    title: 'Title',
    subject: 'Subject',
  );

  // まず単一ページを作る例
  // Page(...): PDFにおける1ページ分のレイアウトを定義するウィジェット
  final page = pw.Page(
    pageTheme: pw.PageTheme(
      // 向きの設定 landscape: 横向き, portrait: 縦向き
      orientation: pw.PageOrientation.landscape,
      // ページのフォーマットを設定
      pageFormat: PdfPageFormat.a4.copyWith(
        marginTop: 20,
        marginBottom: 20,
        marginLeft: 20,
        marginRight: 20,
      )
    ),

    build: (pw.Context context) {
      // ページ内の中心にテキストを配置
      return pw.Center(
        child: pw.Text("PDF Test"),
      );
    },
  );

  final page2 = pw.Page(
      pageTheme: pw.PageTheme(
        theme: pw.ThemeData.withFont(base: font),
      ),
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text("テキスト"),
        );
      }
    );

  List<pw.TableRow> tablerowlist = [];
  for (int i = 0; i < 100; i++) {
    tablerowlist.add(
      pw.TableRow(
        children: [
          // "Test i"を表示するセル
          pw.Text("Test $i"),
          // i の値を表示するセル
          pw.Text("$i"),
        ],
      ),
    );
  }

  // 枠線付きテーブルを作成
  final table = pw.Table(
    border: pw.TableBorder.all(),
    children: tablerowlist,
  );

  // 複数ページを一度にまとめて作るには MultiPage を使う
  // build内に表示したいウィジェットのリストを返す
  final pageM = pw.MultiPage(
    build: (pw.Context context) {
      return [
        table, // 先ほど作成したtableを配置
      ];
    },
  );

  // 先に作成した単一ページをPDFに追加
  pdf.addPage(page);
  pdf.addPage(page2);

  // MultiPageで作成した複数ページをPDFに追加
  pdf.addPage(pageM);

  // 作成したpdfオブジェクトを返す
  return pdf;
}
