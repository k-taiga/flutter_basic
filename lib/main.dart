import 'package:flutter/material.dart';

import 'env.dart';

void main() {
  final apikey = Env.apikey;

  final body = SafeArea(
    child: Text("APIキー：$apikey"),
  );

  final sc = Scaffold(body:body);
  final app = MaterialApp(home: sc,);
  runApp(app);
}
