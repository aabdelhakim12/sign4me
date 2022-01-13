import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:triall/stt.dart';
import 'package:triall/welcomeScreen.dart';

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
      home: Welcome(),
      // home: SpeechToText(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        SpeechToText.routeName: (ctx) => SpeechToText(),
      },
    );
  }
}
