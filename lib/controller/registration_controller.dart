import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  //UserModel? userModel;
  TextEditingController approvedByController = TextEditingController();
  TextEditingController faceImageController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  //TextEditingController statusController = TextEditingController();
  var imagePath;
  var token ;
  registrion() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     token = prefs.getString('token');

    String url = "{{host}}/api/registrations/create";
    
    var request = new http.MultipartRequest("POST", Uri.parse(url));
    request.headers['Authorization'] =
    'Bearer $token';
    request.headers['plateNumber'] = plateNumberController.text;  
  
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      imagePath,
      contentType: MediaType('image', 'png'),
    ));

    try {
    var response = await request.send();
    var res = await http.Response.fromStream(response);

    if (res.statusCode == 200){
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

    }else {
        print('response status code not 200');
      }
      
    //SpellRoot spellRoot=spellRootFromJson(respString);
    } catch (e, s) {
      print("ERRR 200 responsecode");
      print("$e __ $s");
    
  }
    
  
    
     //getx update api data
    // var token =
    //     'YOUR_TOKEN';
    // try {
    //   var body = {
    //     'name': approvedByController.text,
    //     'email': faceImageController.text,
    //     'gender': plateNumberController.text
    //     //'status': statusController.text,
    //   };

    //   http.Response response = await http.put(
    //     Uri.parse('https://smart-parking-server-dev.azurewebsites.net/api/registrations'),
    //     body: jsonEncode(body),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $token'
    //     },
    //   );

    //   if (response.statusCode == 200) {
    //     final json = jsonDecode(response.body);
        
    //   Fluttertoast.showToast(
    //       msg: "Registration successfull",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //     print(json);
    //   } else {
    //     print('response status code not 200');
    //     throw jsonDecode(response.body)['meta']["message"] ??
    //         "Unknown Error Occured";
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }

  
}