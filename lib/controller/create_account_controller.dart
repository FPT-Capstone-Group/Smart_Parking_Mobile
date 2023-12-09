import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountController extends GetxController {
   
  //TextEditingController firstNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  var username;
  Future createAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //var phoneCurrent;
    //const url ='https://smart-parking-server-dev.azurewebsites.net/api/auth/local/register';

    const url = "${Constants.host}/pub/register";
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "fullName": fullNameController.text,
            "username": phoneController.text,
            "password": passwordController.text,
            "otpToken": otpController.text,
             "firebaseToken": otpController.text,
          }));

      if (response.statusCode == 200) {
         Fluttertoast.showToast(
            msg: "You are register in successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
       username = phoneController.text;
        final keyPhoneCurrentRegister = "phoneCurrentRegister";
        final valuePhoneCurrent = username;
        prefs.setString(keyPhoneCurrentRegister, valuePhoneCurrent);

        Get.to(LoginWithPhone(), );
      } else if (response.statusCode == 400) {
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
            msg: "User already exists with same username.",
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
