import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var phoneCurrent;
  var phoneNumber;
  var fullName;
  var deviceFireBasetoken;
  var token;
  var loginSession;
  //User? user;

  Future loginUser() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    const url = "${Constants.host}/pub/login";
    deviceFireBasetoken = prefs.getString("deviceFireBasetoken");
        if(deviceFireBasetoken == null){
          deviceFireBasetoken= "";
        }
      
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "username": phoneNumberController.text,
            "password": passwordController.text,
            "firebaseToken": "abc",
          }));
         // print("device :  + $deviceFireBasetoken");

      if (response.statusCode == 200) {
        loginSession = "true";
         prefs.setString('loginSession', loginSession);
        var loginArr = json.decode(response.body);
      //  phoneNumber = loginArr['data']['user']['username'];
        token = loginArr['data']['token'];
        //save token
        prefs.remove('token');
        prefs.setString('token', token);
    
        //save fullName
        fullName = loginArr['data']['user']['fullName'];
         //fullName = loginArr['data']['fullName'];
        prefs.remove('fullName');
        final keyFullName = 'fullName';
        final fullnameValue = fullName;
        prefs.setString(keyFullName, fullnameValue);
    

        //save phone login current
        phoneCurrent = loginArr['data']['user']['username'];
        //phoneCurrent = loginArr['data']['username'];
        final keyPhoneCurrent = 'phoneCurrent';
        final valuePhoneCurrent = phoneCurrent;
        prefs.setString(keyPhoneCurrent, valuePhoneCurrent);

        Fluttertoast.showToast(
            msg: "You are login successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        Get.to( HomePage(),);
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "Not found.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Incorrect username Id/Password.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }
}
