import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var strtoken;
  
  Future loginUser(BuildContext context) async {
    print("phone: " + phoneNumberController.text);
    print("passs: " + passwordController.text);
  //const url = 'https://smart-parking-server-dev.azurewebsites.net/api/auth/local';
    const url = 'http://localhost:3000/pub/login';

    try {
       Map<String, String> headers = {
      "Content-type": "application/json"
      };
    var response = await http.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode({
          "phoneNumber": phoneNumberController.text,
          "password": passwordController.text,
        }));
    if (response.statusCode == 200) {

        var loginArr = json.decode(response.body);
        strtoken = loginArr['data']['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        final key = 'token';
        final value = strtoken;
        prefs.setString(key, value);

        //var tokenSaved = prefs.getString(key);
        //print("token: " + tokenSaved.toString());
        
        Fluttertoast.showToast(
          msg: "You are login successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // save this token in shared prefrences and make user logged in and navigate
       Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));

    } else {
      Fluttertoast.showToast(
          msg: "Invalid phone or password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,  
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
     } catch (e) {
      //print(e);
    }
  }

} 