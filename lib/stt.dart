import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:video_player/video_player.dart';

class SpeechToText extends StatefulWidget {
  const SpeechToText({Key? key}) : super(key: key);

  @override
  _SpeechToTextState createState() => _SpeechToTextState();
}

const languages = const [
  const Language('Arabic', 'ar_EG'),
  const Language('English', 'en_US'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class _SpeechToTextState extends State<SpeechToText> {
  late SpeechRecognition _speech;
  late VideoPlayerController _controller;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  bool sent = false;

  String transcription = '';
  String asset = 'assets/videos/null.mp4';

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();

    activateSpeechRecognizer();
    _controller = VideoPlayerController.asset(asset)
      ..setLooping(true)
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  void clear() {
    setState(() {
      print(transcription);
      transcription = '';
    });
  }

  void choose() {
    transcription == 'السلام عليكم'
        ? asset = 'assets/videos/1.mp4'
        : transcription == 'انا اسمي عبد الرحمن' ||
                transcription == 'اسمي عبد الرحمن'
            ? asset = 'assets/videos/2.mp4'
            : transcription == 'انا اسمي احمد' || transcription == 'اسمي احمد'
                ? asset = 'assets/videos/4.mp4'
                : transcription == 'انا اسمي محمد' ||
                        transcription == 'اسمي محمد'
                    ? asset = 'assets/videos/3.mp4'
                    : transcription == 'وداعا'
                        ? asset = 'assets/videos/5.mp4'
                        : transcription == 'ماذا تفعل' ||
                                transcription == 'بتعمل ايه'
                            ? asset = 'assets/videos/6.mp4'
                            : transcription == 'ما اسمك' ||
                                    transcription == 'اسمك ايه'
                                ? asset = 'assets/videos/7.mp4'
                                : transcription == 'احبك' ||
                                        transcription == 'باحبك' ||
                                        transcription == 'انا باحبك' ||
                                        transcription == 'انا احبك'
                                    ? asset = 'assets/videos/8.mp4'
                                    : transcription == 'توقف' ||
                                            transcription == 'استني'
                                        ? asset = 'assets/videos/9.mp4'
                                        : transcription == 'كيف حالك' ||
                                                transcription == 'اخبارك' ||
                                                transcription == 'اخبارك ايه' ||
                                                transcription == 'ازيك' ||
                                                transcription == 'عامل ايه'
                                            ? asset = 'assets/videos/10.mp4'
                                            : asset = 'assets/videos/null.mp4';
  }

  void vidodetect() {
    choose();

    _controller = VideoPlayerController.asset(asset)
      ..setLooping(true)
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate('ar_EG').then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Deafs'),
              Text('Language:${selectedLang.code}'),
            ],
          ),
          actions: [
            PopupMenuButton<Language>(
              icon: Icon(Icons.language),
              onSelected: _selectLangHandler,
              itemBuilder: (BuildContext context) => _buildLanguagesWidgets,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _isListening
                    ? Center(
                        child: Container(
                          height: 70,
                          width: 200,
                          child: LoadingIndicator(
                              indicatorType: Indicator.lineScale,
                              colors: [
                                Colors.red,
                                Colors.orange,
                                Colors.yellow,
                                Colors.green,
                                Colors.blue
                              ],
                              strokeWidth: 2,
                              backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                              pathBackgroundColor: Color.fromRGBO(0, 0, 0, 0)),
                        ),
                      )
                    : Container(),
                Text(
                  _isListening ? 'Listening ...' : 'Listen ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  color: Colors.black12,
                  child: Text(
                    transcription,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: size.height * 0.4,
                  child: video(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AvatarGlow(
                      animate: _isListening,
                      glowColor: Theme.of(context).primaryColor,
                      endRadius: 75.0,
                      duration: const Duration(milliseconds: 2000),
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      repeat: _isListening,
                      child: FloatingActionButton(
                        onPressed: _speechRecognitionAvailable && !_isListening
                            ? () {
                                sent = false;
                                start();
                              }
                            : null,
                        child: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                        ),
                      ),
                    ),
                    AvatarGlow(
                        animate: false,
                        glowColor: Theme.of(context).primaryColor,
                        endRadius: 75.0,
                        child: FloatingActionButton(
                          backgroundColor: sent ? Colors.green : null,
                          onPressed: () {
                            sent = true;
                            vidodetect();
                          },
                          child: Icon(
                            !sent ? Icons.send : Icons.done,
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                        elevation: 0,
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
                        onPressed: _isListening ? () => cancel() : null,
                        child: Icon(
                          Icons.cancel,
                          size: 40,
                          color: Colors.red,
                        )),
                    FloatingActionButton(
                        elevation: 0,
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
                        onPressed: _isListening
                            ? () {
                                stop();
                                vidodetect();
                              }
                            : null,
                        child: Icon(
                          Icons.stop,
                          size: 40,
                          color: Colors.black,
                        )),
                    FloatingActionButton(
                        elevation: 0,
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
                        onPressed: () {
                          clear();
                          sent = false;
                        },
                        child: Icon(Icons.delete, size: 40, color: Colors.red)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
      .map((l) => CheckedPopupMenuItem<Language>(
            value: l,
            checked: selectedLang == l,
            child: Text(l.name),
          ))
      .toList();

  void _selectLangHandler(Language lang) {
    setState(() => selectedLang = lang);
  }

  void start() => _speech.activate(selectedLang.code).then((_) {
        return _speech.listen().then((result) {
          print('_MyAppState.start => result $result');
          setState(() => _isListening = result);
        });
      });

  void cancel() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));

  void stop() => _speech.stop().then((_) => setState(() {
        _isListening = false;
      }));

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print(
        'lllllllllllllllllllllllllllllllllllllllllllllllll _MyAppState.onCurrentLocale... $locale lllllllllllllllllllllllllllllllllllllllllllllllll');
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print(
        '========================================_MyAppState.onRecognitionResult... $text ========================================');
    setState(() {
      transcription = text;
      // vidodetect();
    });
  }

  void onRecognitionComplete(String text) {
    print(
        'cccccccccccccccccccccccccccccccccccccccccccc_MyAppState.onRecognitionComplete... $text ccccccccccccccccccccccccccccccccccccccccccccc');
    setState(() {
      _isListening = false;
    });
  }

  void errorHandler() => activateSpeechRecognizer();
  Widget video() {
    var size = _controller.value.size;
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
