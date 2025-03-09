import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

import 'package:flutter/services.dart';

void main() {
  // PdfPreviewウィジェットの中身を用意
  final body = Center(
    child: PdfPreview(
      allowPrinting: false, // 印刷ボタンを表示しない
      allowSharing: false, // 共有ボタンを表示しない
      canChangeOrientation: false, // 用紙の向きを変更できない
      canChangePageFormat: false, // 用紙サイズを変更できない
      canDebug: false, // デバッグボタンを表示しない
      // build: 生成したいPDFを返す非同期関数を指定
      build: (format) async {
        final pdf = await makePdf();
        // 生成したpdfをバイナリ( Uint8List )で返す
        return await pdf.save();
      },
    ),
  );

  final sc = Scaffold(body: body);
  final app = MaterialApp(home: sc);

  runApp(app);
}

// PDFドキュメントを生成する非同期関数
Future<pw.Document> makePdf() async {
  final fontData =
      await rootBundle.load("assets/fonts/ShipporiMincho-Regular.ttf");
  final font = pw.Font.ttf(fontData);

  // PDF Documentの作成
  final pdf = pw.Document();

  // まず単一ページを作る例
  // Page(...): PDFにおける1ページ分のレイアウトを定義するウィジェット
  final page = pw.Page(
    build: (pw.Context context) {
      // ページ内の中心にテキストを配置
      return pw.Center(
        child: pw.Text("PDF Test"),
      );
    },
  );

  final page2 = pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: font),
      ),
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text("テキスト"),
        );
      });

  List<pw.TableRow> tablerowlist = [];
  // forループを使って10行分のデータを生成
  for (int i = 0; i < 10; i++) {
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

  // MultiPageで作成した複数ページをPDFに追加
  pdf.addPage(pageM);

  // 作成したpdfオブジェクトを返す
  return pdf;
}
