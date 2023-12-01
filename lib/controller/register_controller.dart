import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
   
  //TextEditingController firstNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var username;
  Future registerUser() async {
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
          }));
      print("register page");
      if (response.statusCode == 200) {
        // var registerArr = json.decode(response.body);

        //save phone login current
       username = phoneController;
        final keyPhoneCurrent = 'phoneCurrent';
        final valuePhoneCurrent = username;
        prefs.setString(keyPhoneCurrent, valuePhoneCurrent);

        Fluttertoast.showToast(
            msg: "You are register in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.to(LoginWithPhone(), );
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: "User already exists with same phoneNumber",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "User already exists with same username",
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
