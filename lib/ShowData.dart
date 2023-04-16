import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_health_tab/Load.dart';
import 'package:project_health_tab/showdone.dart';

import 'Brain/MainFuctions.dart';
import 'color.dart';

class ShowData extends StatefulWidget {
  var id;
  ShowData({super.key,required this.id});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
   List data_txt = [];
   String name = '';
   String age = '';
   String phone = '';
   String email = '';
   String depart = '';
   String addres = '';
   String registdate = '';
   String id = '';
   String departid = '';
  Future<void> apiPatient() async {
    Load().data(context);
    if(widget.id.toString().isEmpty){
      print("ID is null");
      Navigator.pop(context);
    }
   else{
     dynamic response = await Brain().getpatientdata(widget.id.toString());
    var data = jsonDecode(response);
      setState(() {
        data_txt = data;
        id  = data_txt[0]['id']?? "0";
        name  = data_txt[0]['user_name']??"";
        age  = data_txt[0]['user_age']??"";
        phone  = data_txt[0]['user_phone']??"";
        email  = data_txt[0]['user_email']??"";
        departid  = data_txt[0]['user_department']??"";
        addres  = data_txt[0]['user_address']??"";
        registdate  = data_txt[0]['regisdate']??"";
        Navigator.pop(context);
      });
       _speak();
      getdepartment();
   }
  }


   

  Future<void> scanner() async {
    Load().data(context);
    if(name.isEmpty
    && depart.isEmpty
    ){
      print("ID is null");
      Navigator.pop(context);
    }
   else{
     dynamic response = await Brain().scanner(id, name, departid, "0");
    var data = jsonDecode(response);
     print(data);
       if (data['status'].toString().contains("0")) {
         Navigator.pop(context);
         Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowDone()));
       }
       else{
         Navigator.pop(context);
       }
   }
  }
  List li = [];     
  FlutterTts flutterTts = FlutterTts();


   Future<void> getdepartment() async {
 
    dynamic response = await Brain().getdepartment(departid);
    print(response);
    var data = jsonDecode(response);
     setState(() {
       li = data;
      //print(li[0]['id']);
       depart = li[0]['department_name'];
     });
    }
  
  @override
  void initState() {
   SchedulerBinding.instance.addPostFrameCallback((_) {
    apiPatient();
   
});
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
                  Text("Welcome",style: GoogleFonts.poppins(fontSize: 25,color: impColor,fontWeight: FontWeight.w500),),
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
      body: Center(
        child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         Expanded(
          child: GestureDetector(
                    onTap: () async =>
                    {
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                  
                      children: [
                       
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(left: 20,top: 20),
                         
                          child: Column(
                            children: [
                              Container(
                                    alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text("Name:",style: GoogleFonts.poppins(fontSize: 20),),
                                    SizedBox(width: 12,),
                                    Text(name,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),)
                                  ],
                                )
                              ),
                              Container(
                                    alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text("Age:",style: GoogleFonts.poppins(fontSize: 20),),
                                    SizedBox(width: 12,),
                                    Text(age,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),)
                                  ],
                                )
                              ),
                              Container(
                                    alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text("Phone:",style: GoogleFonts.poppins(fontSize: 20),),
                                    SizedBox(width: 12,),
                                    Text(phone,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),)
                                  ],
                                )
                              ),
                              Container(
                                    alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text("Email:",style: GoogleFonts.poppins(fontSize: 20),),
                                    SizedBox(width: 12,),
                                    Text(email,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),)
                                  ],
                                )
                              ),
                              Container(
                                    alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text("Department:",style: GoogleFonts.poppins(fontSize: 20),),
                                    SizedBox(width: 12,),
                                    Text(depart,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),)
                                  ],
                                )
                              ),
                              Container(
                                    alignment: Alignment.centerLeft,
                                child: Row( 
                                  children: [
                                    Text("Address:",style: GoogleFonts.poppins(fontSize: 20),),
                                    SizedBox(width: 12,),
                                    Text(addres,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),)
                                  ],
                                )
                              ),
                              Container(
                                    alignment: Alignment.centerLeft,
                                child: Row( 
                                  children: [
                                    Text("Register Date:",style: GoogleFonts.poppins(fontSize: 20),),
                                    SizedBox(width: 12,),
                                    Text(registdate,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),)
                                  ],
                                )
                              ),
                              SizedBox(height: 100,),
                           OutlinedButton(
                          
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('Submit',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),),
          ),
          style: OutlinedButton.styleFrom(
            primary: Color.fromARGB(255, 0, 0, 0),
          side: BorderSide(color: Colors.black)
          ),
          onPressed: () =>{
            scanner()
          },
                          
                             )
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                  
         ),
        ],
      ),
      
        ),
      ),
    );
  }
   Future _speak() async{
     await flutterTts.speak("Check Your Details and Submit ");
     await flutterTts.setLanguage("en-US");
     await flutterTts.setSpeechRate(.5);

await flutterTts.setVolume(1.0);

await flutterTts.setPitch(1.0);

}
}