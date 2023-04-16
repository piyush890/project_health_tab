import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_health_tab/ShowData.dart';
import 'package:project_health_tab/color.dart';
import 'package:flutter_tts/flutter_tts.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainPage()
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
     String qrCode = 'Unknown';
     FlutterTts flutterTts = FlutterTts();

     @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

                       _speak();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(preferredSize: Size.fromHeight(60), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(

                children: [
                  Text("Welcome in",style: GoogleFonts.poppins(fontSize: 25,color: impColor,fontWeight: FontWeight.w500),),
                  Container(
                     margin: EdgeInsets.only(left: 50),
                    child: Text("Bot-o+",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w700),)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: IconButton(onPressed: ()=>{}, icon: Icon(Icons.adobe_outlined)),
            )
          ],
        )),
    
      ),
      body: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         Expanded(
          child: GestureDetector(
                    onTap: () async =>
                    {
                   scanQRCode(),
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(25),
                          
                          decoration: BoxDecoration(
                            color: impColor,
                            borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.qr_code_2_rounded,size: 150,color: Colors.white,),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                         
                          child: Text("SCAN QR",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                        )
                      ],
                    ),
                  ),
         ),
         Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(left: 200),
            child: Image.asset('assets/images/leaf.png',)),
         ),
        ],
      ),
      )
    );
  }
  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (qrCode.isNotEmpty) {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowData(id: qrCode)));
      }
      
       
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
  Future _speak() async{
     await flutterTts.speak("Please Scan Your QR Code ");
     await flutterTts.setLanguage("en-US");
     await flutterTts.setSpeechRate(.5);

await flutterTts.setVolume(1.0);

await flutterTts.setPitch(1.0);

}
}