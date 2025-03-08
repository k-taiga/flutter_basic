import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _msg = "";
  bool _isChecked = false;
  int _radioValue = 0;
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    const text = Text('Hello, Flutter');
    const textArea = Column(
      children: [
        text,
      ],
    );

    final button = ElevatedButton(
      onPressed: () {
        print("ボタンが");
        print("押されました");
      },
      child: const Text("ボタン"),
    );

    fn() {
      print("関数実行");
    }

    final textButton = TextButton(
      onPressed: fn,
      child: const Text("テキストボタン"),
    );

    final buttonArea = Row(
      children: [button, textButton],
    );

    final textFieldText = Text('メッセージ $_msg');
    final controller = TextEditingController();

    final textField = TextField(
      controller: controller,
      autofocus: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '内容',
        hintText: '100文字以内で入力してください',
      ),
      onChanged: (String text) {
        print("value: $text");
      },
    );

    setMsg() {
      setState(() {
        _msg = controller.text;
      });
    }

    clear() {
      controller.clear();
    }

    final setMsgButton = ElevatedButton(
      onPressed: setMsg,
      child: const Text("反映"),
    );

    final clearButton = ElevatedButton(
      onPressed: clear,
      child: const Text("クリア"),
    );

    final textFieldArea = Column(
      children: [
        textFieldText,
        textField,
        Row(
          children: [setMsgButton, clearButton],
        )
      ],
    );

    final isCheckedText = Text("チェック: ${_isChecked ? 'ON' : 'OFF'}");

    final checkBox = Checkbox(
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
        });
      },
    );

    const checkBoxText = Text("チェックボックス");

    final checkBoxAre = Row(
      children: [
        isCheckedText,
        checkBoxText,
        checkBox,
      ],
    );

    final radio1 = Radio(
      value: 1,
      groupValue: _radioValue,
      onChanged: (int? value) {
        setState(() {
          _radioValue = value!;
        });
      },
    );

    const radio1Text = Text("Android");

    final radio2 = Radio(
      value: 2,
      groupValue: _radioValue,
      onChanged: (int? value) {
        setState(() {
          _radioValue = value!;
        });
      },
    );

    const radio2Text = Text("iOS");

    const radioMap = {0: "未選択", 1: "Android", 2: "iOS"};
    final radioText = Text("デバイス: ${radioMap[_radioValue]}");

    final radioArea = Row(
      children: [
        radio1,
        radio1Text,
        const SizedBox(width: 10.0),
        radio2,
        radio2Text,
        const SizedBox(width: 20.0),
        radioText
      ],
    );

    final switchText = Text(_isOn ? "ON" : "OFF");
    final toggle = Switch(
      value: _isOn,
      onChanged: (bool value) {
        setState(() {
          _isOn = value;
        });
      },
    );

    final switchArea = Row(
      children: [switchText, toggle],
    );

    final body = SafeArea(
      child: Column(
        children: [
          textArea,
          buttonArea,
          textFieldArea,
          checkBoxAre,
          radioArea,
          switchArea,
        ],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
