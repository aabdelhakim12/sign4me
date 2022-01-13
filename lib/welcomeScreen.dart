import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triall/stt.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff14161a),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff2e3037), Color(0xff14161a)]),
          ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              Center(
                  child: Text(
                'Sign4me',
                style: GoogleFonts.poppins(color: Colors.white30, fontSize: 20),
              )),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Welcome ',
                              style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w300)),
                          Text('to our ',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Text('communication platform.',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xff224ebf), Color(0xff16298c)])),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SpeechToText.routeName);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                      child: Text('    Get Started    ',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: (size.width - size.height * 0.4) / 2,
          bottom: 0,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: size.height * 0.4,
              height: size.height * 0.4,
              child: Image.asset(
                'assets/images/blue.png',
                // color: Color(0xff224ebf),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
