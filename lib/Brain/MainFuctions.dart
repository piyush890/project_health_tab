import 'dart:convert';

import 'package:http/http.dart' as http;

import 'BaseURL.dart';
class Brain{
    Future<String> getpatientdata(id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(BaseUrl.getPatientdata),
         body: jsonEncode(
          {
           "patient_id":id
           }
         
         )
        );

        String res = response.body;
        
    return res;
  }
    Future<String> scanner(id,name,department,scanned) async {
    dynamic response;
    response = await http.post(
         Uri.parse(BaseUrl.scannedData),
         body: jsonEncode(
        {
        "id":id,
        "name":name,
        "department":department,
        "scanned":scanned

         }   
         
         )
        );

        String res = response.body;
        
    return res;
  }

      Future<String> getdepartment(id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(BaseUrl.getparticulardepartment),
         body: jsonEncode({
          "id": id
         })
         
        );

        String res = response.body;
        
    return res;
  }
}