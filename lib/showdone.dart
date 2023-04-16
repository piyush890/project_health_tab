import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_health_tab/main.dart';

class ShowDone extends StatefulWidget {
  const ShowDone({super.key});

  @override
  State<ShowDone> createState() => _ShowDoneState();
}

class _ShowDoneState extends State<ShowDone> {
    FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    _speak();
    Timer(
            Duration(seconds: 4),
                () =>
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainPage()), (route) => false)
            );

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 500,
              child: LottieBuilder.asset('assets/images/ok.json')),
            SizedBox(height: 20,),
            Text("Thank You \n You Can Go Now",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: Color.fromARGB(255, 107, 102, 243),fontSize: 30,fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
     Future _speak() async{
     await flutterTts.speak("Verified");
     await flutterTts.speak("Thank You Have a Good Day");
     await flutterTts.setLanguage("en-US");
     await flutterTts.setSpeechRate(.5);

await flutterTts.setVolume(1.0);

await flutterTts.setPitch(1.0);

}
}