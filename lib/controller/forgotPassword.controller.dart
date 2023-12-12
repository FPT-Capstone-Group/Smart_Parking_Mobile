import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  var username;
  Future forgotPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    const url = "${Constants.host}/api/forgotPassword";
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "username": phoneController.text,
            "newPassword": passwordController.text,
            "otpToken": otpController.text,
          }));

      if (response.statusCode == 200) {
         Fluttertoast.showToast(
            msg: "You are set new password in successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        username = phoneController.text;
        prefs.remove('phoneCurrentRegister');
        final keyPhoneCurrentRegister = "phoneCurrentRegister";
        final valuePhoneCurrent = username;
        prefs.setString(keyPhoneCurrentRegister, valuePhoneCurrent);

        Get.to(LoginWithPhone(), );
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "Not found.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 500){
      
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }else{

      }
    } catch (e) {
      print(e);
    }
  }
}
