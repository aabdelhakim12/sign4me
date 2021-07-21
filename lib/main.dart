import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:triall/stt.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpeechToText(),
      debugShowCheckedModeBanner: false,
    );
  }
}
