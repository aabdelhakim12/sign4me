import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:triall/refersh.dart';
// import 'package:video_player/video_player.dart';

class SpeechToText extends StatefulWidget {
  static const routeName = '/drw';
  const SpeechToText({Key? key}) : super(key: key);

  @override
  _SpeechToTextState createState() => _SpeechToTextState();
}

const languages = const [
  const Language('Arabic', 'ar_EG'),
  const Language('English', 'en_US'),
  const Language('Francais', 'fr_FR'),
  const Language('Español', 'es_ES'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class _SpeechToTextState extends State<SpeechToText> {
  late SpeechRecognition _speech;
  // late VideoPlayerController _controller;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';
  String asset = 'assets/gifs/null.gif';
  var color = Colors.grey[300];

  // String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();

    activateSpeechRecognizer();
  }

  void choose() {
    transcription == 'hi' || transcription == 'hello'
        ? asset = 'assets/gifs/hi.gif'
        : transcription == 'my name is Ahmed' || transcription == 'I am Ahmed'
            ? asset = 'assets/gifs/my_name_is_ahmed.gif'
            : transcription == 'how are you'
                ? asset = 'assets/gifs/how_are_you.gif'
                : transcription == 'goodbye'
                    ? asset = 'assets/gifs/goodbye.gif'
                    : transcription == 'السلام عليكم' ||
                            transcription == 'مرحبا' ||
                            transcription == 'سلام عليكم'
                        ? asset = 'assets/gifs/1.gif'
                        : transcription == 'انا اسمي عبد الرحمن' ||
                                transcription == 'اسمي عبد الرحمن'
                            ? asset = 'assets/gifs/2.gif'
                            : transcription == 'انا اسمي احمد' ||
                                    transcription == 'اسمي احمد'
                                ? asset = 'assets/gifs/4.gif'
                                : transcription == 'انا اسمي محمد' ||
                                        transcription == 'اسمي محمد'
                                    ? asset = 'assets/gifs/3.gif'
                                    : transcription == 'وداعا' ||
                                            transcription == 'مع السلامه'
                                        ? asset = 'assets/gifs/5.gif'
                                        : transcription == 'ماذا تفعل' ||
                                                transcription == 'بتعمل ايه'
                                            ? asset = 'assets/gifs/6.gif'
                                            : transcription == 'ما اسمك' ||
                                                    transcription == 'اسمك ايه'
                                                ? asset = 'assets/gifs/7.gif'
                                                : transcription == 'احبك' ||
                                                        transcription ==
                                                            'باحبك' ||
                                                        transcription ==
                                                            'انا باحبك' ||
                                                        transcription ==
                                                            'انا احبك'
                                                    ? asset =
                                                        'assets/gifs/8.gif'
                                                    : transcription == 'توقف' ||
                                                            transcription ==
                                                                'استني'
                                                        ? asset =
                                                            'assets/gifs/9.gif'
                                                        : transcription ==
                                                                    'كيف حالك' ||
                                                                transcription ==
                                                                    'اخبارك' ||
                                                                transcription ==
                                                                    'اخبارك ايه' ||
                                                                transcription ==
                                                                    'ازيك' ||
                                                                transcription ==
                                                                    'عامل ايه'
                                                            ? asset =
                                                                'assets/gifs/10.gif'
                                                            : transcription ==
                                                                    'ابراهيم'
                                                                ? asset =
                                                                    'assets/gifs/ابراهيم.gif'
                                                                : transcription ==
                                                                        'احمد'
                                                                    ? asset =
                                                                        'assets/gifs/احمد.gif'
                                                                    : transcription ==
                                                                                'ازاي' ||
                                                                            transcription ==
                                                                                'كيف'
                                                                        ? asset =
                                                                            'assets/gifs/ازاي.gif'
                                                                        : transcription == 'الى' ||
                                                                                transcription == 'لحد'
                                                                            ? asset = 'assets/gifs/الى.gif'
                                                                            : transcription == 'قدام' || transcription == 'امام'
                                                                                ? asset = 'assets/gifs/امام.gif'
                                                                                : transcription == 'انا'
                                                                                    ? asset = 'assets/gifs/انا.gif'
                                                                                    : transcription == 'انت'
                                                                                        ? asset = 'assets/gifs/انت.gif'
                                                                                        : transcription == 'انتم'
                                                                                            ? asset = 'assets/gifs/انتم.gif'
                                                                                            : transcription == 'اين' || transcription == 'فين'
                                                                                                ? asset = 'assets/gifs/اين.gif'
                                                                                                : transcription == 'برج' || transcription == 'عماره'
                                                                                                    ? asset = 'assets/gifs/برج.gif'
                                                                                                    : transcription == 'بص' || transcription == 'شف'
                                                                                                        ? asset = 'assets/gifs/بص.gif'
                                                                                                        : transcription == 'بيت' || transcription == 'منزل'
                                                                                                            ? asset = 'assets/gifs/بيت.gif'
                                                                                                            : transcription == 'اسفل' || transcription == 'تحت'
                                                                                                                ? asset = 'assets/gifs/تحت.gif'
                                                                                                                : transcription == 'ماشي' || transcription == 'تمام'
                                                                                                                    ? asset = 'assets/gifs/تمام.gif'
                                                                                                                    : transcription == 'خالد'
                                                                                                                        ? asset = 'assets/gifs/خالد.gif'
                                                                                                                        : transcription == 'خلف' || transcription == 'وراء'
                                                                                                                            ? asset = 'assets/gifs/خلف.gif'
                                                                                                                            : transcription == 'دكتور' || transcription == 'طبيب'
                                                                                                                                ? asset = 'assets/gifs/دكتور.gif'
                                                                                                                                : transcription == 'رضا'
                                                                                                                                    ? asset = 'assets/gifs/رضا.gif'
                                                                                                                                    : transcription == 'سياره' || transcription == 'عربيه'
                                                                                                                                        ? asset = 'assets/gifs/سيارة.gif'
                                                                                                                                        : transcription == 'شجره'
                                                                                                                                            ? asset = 'assets/gifs/شجرة.gif'
                                                                                                                                            : transcription == 'عبد الغفار'
                                                                                                                                                ? asset = 'assets/gifs/عبدالغفار.gif'
                                                                                                                                                : transcription == 'علي'
                                                                                                                                                    ? asset = 'assets/gifs/على.gif'
                                                                                                                                                    : transcription == 'عن'
                                                                                                                                                        ? asset = 'assets/gifs/عن.gif'
                                                                                                                                                        : transcription == 'فوق'
                                                                                                                                                            ? asset = 'assets/gifs/فوق.gif'
                                                                                                                                                            : transcription == 'كتاب'
                                                                                                                                                                ? asset = 'assets/gifs/كتاب.gif'
                                                                                                                                                                : transcription == 'كرسي' || transcription == 'المقعد'
                                                                                                                                                                    ? asset = 'assets/gifs/كرسي.gif'
                                                                                                                                                                    : transcription == 'ليه' || transcription == 'لماذا'
                                                                                                                                                                        ? asset = 'assets/gifs/لماذا.gif'
                                                                                                                                                                        : transcription == 'ما' || transcription == 'ماذا'
                                                                                                                                                                            ? asset = 'assets/gifs/ما.gif'
                                                                                                                                                                            : transcription == 'محمد'
                                                                                                                                                                                ? asset = 'assets/gifs/محمد.gif'
                                                                                                                                                                                : transcription == 'مدرس' || transcription == 'معلم'
                                                                                                                                                                                    ? asset = 'assets/gifs/مدرس.gif'
                                                                                                                                                                                    : transcription == 'مدرسه' || transcription == 'معلمه'
                                                                                                                                                                                        ? asset = 'assets/gifs/مدرسه.gif'
                                                                                                                                                                                        : transcription == 'مستشفى'
                                                                                                                                                                                            ? asset = 'assets/gifs/مستشفى.gif'
                                                                                                                                                                                            : transcription == 'مصباح'
                                                                                                                                                                                                ? asset = 'assets/gifs/مصباح.gif'
                                                                                                                                                                                                : transcription == 'هؤلاء'
                                                                                                                                                                                                    ? asset = 'assets/gifs/هؤلاء.gif'
                                                                                                                                                                                                    : transcription == 'هم'
                                                                                                                                                                                                        ? asset = 'assets/gifs/هم.gif'
                                                                                                                                                                                                        : transcription == 'هنا'
                                                                                                                                                                                                            ? asset = 'assets/gifs/هن.gif'
                                                                                                                                                                                                            : transcription == 'هو'
                                                                                                                                                                                                                ? asset = 'assets/gifs/هو.gif'
                                                                                                                                                                                                                : transcription == 'هي'
                                                                                                                                                                                                                    ? asset = 'assets/gifs/هي.gif'
                                                                                                                                                                                                                    : transcription == 'ياكل'
                                                                                                                                                                                                                        ? asset = 'assets/gifs/ياكل.gif'
                                                                                                                                                                                                                        : transcription == 'يجري'
                                                                                                                                                                                                                            ? asset = 'assets/gifs/يجري.بمعgif'
                                                                                                                                                                                                                            : transcription == 'يذاكر' || transcription == 'يدرس'
                                                                                                                                                                                                                                ? asset = 'assets/gifs/يدرس.gif'
                                                                                                                                                                                                                                : transcription == 'يشرب'
                                                                                                                                                                                                                                    ? asset = 'assets/gifs/يشرب.gif'
                                                                                                                                                                                                                                    : transcription == 'يقف'
                                                                                                                                                                                                                                        ? asset = 'assets/gifs/يقف.gif'
                                                                                                                                                                                                                                        : transcription == 'يلعب'
                                                                                                                                                                                                                                            ? asset = 'assets/gifs/يلعب.gif'
                                                                                                                                                                                                                                            : transcription == 'يمشي' || transcription == 'يسير'
                                                                                                                                                                                                                                                ? asset = 'assets/gifs/يمشي.gif'
                                                                                                                                                                                                                                                : transcription == 'a head'
                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/ahead.gif'
                                                                                                                                                                                                                                                    : transcription == 'behind'
                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/behind.gif'
                                                                                                                                                                                                                                                        : transcription == 'book'
                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/book.gif'
                                                                                                                                                                                                                                                            : transcription == 'building'
                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/building.gif'
                                                                                                                                                                                                                                                                : transcription == 'car'
                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/car.gif'
                                                                                                                                                                                                                                                                    : transcription == 'chair'
                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/chair.gif'
                                                                                                                                                                                                                                                                        : transcription == 'doctor'
                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/doctor.gif'
                                                                                                                                                                                                                                                                            : transcription == 'drink'
                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/drink.gif'
                                                                                                                                                                                                                                                                                : transcription == 'eating'
                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/eating.gif'
                                                                                                                                                                                                                                                                                    : transcription == 'he' || transcription == 'she'
                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/he.gif'
                                                                                                                                                                                                                                                                                        : transcription == 'home'
                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/home.gif'
                                                                                                                                                                                                                                                                                            : transcription == 'home'
                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/home.gif'
                                                                                                                                                                                                                                                                                                : transcription == 'Hospital'
                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/hospital.gif'
                                                                                                                                                                                                                                                                                                    : transcription == 'how'
                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/how.gif'
                                                                                                                                                                                                                                                                                                        : transcription == 'I am'
                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/iam.gif'
                                                                                                                                                                                                                                                                                                            : transcription == 'lamp'
                                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/lamp.gif'
                                                                                                                                                                                                                                                                                                                : transcription == 'I love you'
                                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/iloveyou.gif'
                                                                                                                                                                                                                                                                                                                    : transcription == 'look at'
                                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/lookat.gif'
                                                                                                                                                                                                                                                                                                                        : transcription == 'Muhammad'
                                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/mohamed.gif'
                                                                                                                                                                                                                                                                                                                            : transcription == 'okay' || transcription == 'ok'
                                                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/okay.gif'
                                                                                                                                                                                                                                                                                                                                : transcription == 'on'
                                                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/on.gif'
                                                                                                                                                                                                                                                                                                                                    : transcription == 'play'
                                                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/play.gif'
                                                                                                                                                                                                                                                                                                                                        : transcription == 'run'
                                                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/run.gif'
                                                                                                                                                                                                                                                                                                                                            : transcription == 'stand'
                                                                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/stand.gif'
                                                                                                                                                                                                                                                                                                                                                : transcription == 'study'
                                                                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/study.gif'
                                                                                                                                                                                                                                                                                                                                                    : transcription == 'teacher'
                                                                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/teacher.gif'
                                                                                                                                                                                                                                                                                                                                                        : transcription == 'them'
                                                                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/them.gif'
                                                                                                                                                                                                                                                                                                                                                            : transcription == 'they'
                                                                                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/they.gif'
                                                                                                                                                                                                                                                                                                                                                                : transcription == 'towards'
                                                                                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/to.gif'
                                                                                                                                                                                                                                                                                                                                                                    : transcription == 'tree'
                                                                                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/tree.gif'
                                                                                                                                                                                                                                                                                                                                                                        : transcription == 'under'
                                                                                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/under.gif'
                                                                                                                                                                                                                                                                                                                                                                            : transcription == 'up'
                                                                                                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/up.gif'
                                                                                                                                                                                                                                                                                                                                                                                : transcription == 'walk'
                                                                                                                                                                                                                                                                                                                                                                                    ? asset = 'assets/gifs/walk.gif'
                                                                                                                                                                                                                                                                                                                                                                                    : transcription == 'what'
                                                                                                                                                                                                                                                                                                                                                                                        ? asset = 'assets/gifs/what.gif'
                                                                                                                                                                                                                                                                                                                                                                                        : transcription == 'why'
                                                                                                                                                                                                                                                                                                                                                                                            ? asset = 'assets/gifs/why.gif'
                                                                                                                                                                                                                                                                                                                                                                                            : transcription == 'you'
                                                                                                                                                                                                                                                                                                                                                                                                ? asset = 'assets/gifs/you.gif'
                                                                                                                                                                                                                                                                                                                                                                                                : asset = 'assets/gifs/null.gif';
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
    var soundBars = LoadingIndicator(
        indicatorType: Indicator.lineScalePulseOut,
        colors: [
          Colors.grey,
          Colors.grey,
          Colors.grey,
          Colors.grey,
          Colors.grey
        ],
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        pathBackgroundColor: Color.fromRGBO(0, 0, 0, 0));
    return Scaffold(
      body: Stack(children: [
        Positioned(
          child: Container(
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff2e3037), Color(0xff14161a)]),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 55, bottom: 10),
                    child: Text(
                      'Voice to sign language',
                      style: GoogleFonts.poppins(
                          color: Colors.white30, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ....................image ................
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Image.asset(
                          asset,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: Colors.grey[50],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _isListening
                                ? Text('   Listening ... ',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xffCE493D),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600))
                                : Container(),
                            Center(
                              child: Text(
                                transcription,
                                style: GoogleFonts.poppins(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _isListening
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      soundBars,
                                      soundBars,
                                      soundBars,
                                      soundBars,
                                      soundBars,
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            margin: EdgeInsets.only(top: 60),
            width: size.width,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Color(0xff2e3037)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) {
                          return Refersh();
                        }));
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) {
                          return SpeechToText();
                        }));
                      },
                      icon: Image.asset('assets/images/redo.png')),
                  SizedBox(width: 100),
                  PopupMenuButton<Language>(
                    icon: Image.asset('assets/images/language.png'),
                    onSelected: _selectLangHandler,
                    itemBuilder: (BuildContext context) =>
                        _buildLanguagesWidgets,
                  ),
                ]),
          ),
        ),
        Positioned(
          bottom: 45,
          left: (size.width - 60) / 2,
          child: GestureDetector(
            onLongPress: _speechRecognitionAvailable && !_isListening
                ? () {
                    setState(() {
                      start();
                    });
                  }
                : null,
            onLongPressEnd: (LongPressEndDetails details) {
              Timer(Duration(milliseconds: 1300), () {
                cancel();
                choose();
                setState(() {});
                selectedLang.code == 'ar_EG'
                    ? color = Colors.grey[300]
                    : color = Colors.white;
                if (asset == 'assets/gifs/null.gif') {
                  color = Colors.grey[300];
                }
              });
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xff224ebf), Color(0xff16298c)])),
              child: AvatarGlow(
                  animate: _isListening,
                  glowColor: Color(0xff224ebf),
                  endRadius: 60,
                  duration: Duration(milliseconds: 2000),
                  repeatPauseDuration: Duration(milliseconds: 100),
                  repeat: _isListening,
                  child: Image.asset(
                    'assets/images/mic.png',
                    height: 40,
                  )),
            ),
          ),
        ),
      ]),
    );
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

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    setState(() {
      transcription = text;
    });
  }

  void onRecognitionComplete(String text) {
    print('_MyAppState.onRecognitionComplete... $text');
    setState(() {
      _isListening = false;
    });
  }

  void errorHandler() => activateSpeechRecognizer();

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }
}
