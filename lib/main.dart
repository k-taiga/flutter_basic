import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isOn = false;

  _MyHomePageState() {
    final f = _loadSettingA();
    f.then((value) => {
          setState(() {
            _isOn = value;
          })
        });
  }

  Future<void> _saveSettingA(bool value) async {
    // shared_preferencesのインスタンスを取得
    final prefs = await SharedPreferences.getInstance();

    // shared_preferencesにデータを保存
    await prefs.setBool(
        'settingA',
        value);
  }

  // shared_preferencesからデータを取得
  Future<bool> _loadSettingA() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool('settingA');
    return value ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final switchText = Text(_isOn ? "設定A:オン" : "設定A:オフ");
    final toggle = Switch(
      value: _isOn,
      onChanged: (value) {
        setState(() {
          _isOn = value;
          _saveSettingA(value);
        });
      },
    );

    final body = SafeArea(
      child: Row(
        children: [
          switchText,
          toggle,
        ],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
