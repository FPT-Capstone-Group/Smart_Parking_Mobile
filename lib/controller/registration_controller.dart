import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationBike {

  TextEditingController approvedByController = TextEditingController();
  TextEditingController faceImagePath = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();

  //String? imagePath;
  var token;
  Future registrion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    print('token: ' + token);
    
    var imagePath = prefs.getString('imagePath').toString();
    print('imagePath: ' + imagePath);
    //localhost test api
    //String url = "http://localhost:3000/api/registrations/create";
    // mobile test localhost
    String urlLocalhost = "http://192.168.1.3:3000/api/registrations/create";

    //String urlLocalhost = "http://192.168.0.11:3000/api/registrations/create";

    var request = new http.MultipartRequest("POST", Uri.parse(urlLocalhost));
    request.headers['Authorization'] = 'Bearer $token';
    //request.headers['Content-Type'] ='multipart/form-data';

    request.fields['approvedBy'] = approvedByController.text;
    request.fields['plateNumber'] = plateNumberController.text;
    request.files.add(await http.MultipartFile.fromPath(
      'faceImage',
      imagePath.toString(),
      contentType: new MediaType('image', 'jpg'),
    ));

    try {
      var response = await request.send();
      var res = await http.Response.fromStream(response);

      final Map<String, dynamic> parsed = json.decode(res.body);
      print("parsed");
      print(parsed);
      print("-------------------------------");
      prefs.remove('imagePath');
      print("-------------------------------");
      if (res.statusCode == 200) {
        print("SUCCESS! 200 HTTP");

        Fluttertoast.showToast(
            msg: "Registration successfull",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        print("HTTP CODE:${res.statusCode}");
        String respString = res.body;
        print("respString::$respString");
      } else {
        print(response.statusCode);
        print('response status code not 200');
      }

      //SpellRoot spellRoot=spellRootFromJson(respString);
    } catch (e, s) {
      print("ERRR 200 responsecode");
      print("$e __ $s");
    }
  }
}
