import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordController{
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future changePassword() async {
    try {
      String url = "${Constants.host}/api/changePassword";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token').toString();
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "oldPassword": oldPasswordController.text,
            "newPassword": newPasswordController.text,
          }));
     // print('StatusCode ${response.statusCode}: $url');
      if (response.statusCode == 200) {
       
        Fluttertoast.showToast(
            msg: "Change Password Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      Get.to(const HomePage());
      } else if (response.statusCode == 401) {
        print("Erro code 401: fail token: Invalid token signature");
      }
      else if (response.statusCode == 500) {
       Fluttertoast.showToast(
            msg: "Old password is incorrect",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Change Password Fail",
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
