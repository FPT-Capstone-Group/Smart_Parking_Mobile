import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController{
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  Future updateUser() async {
    try {
      //String url = "${Constants.host}/api/payments/submit";
      String url = "${Constants.host}/api/users/update";
      //const url = 'http://localhost:3000/pub/login';

      //wifi localhost test real mobile
      //String url = "http://192.168.0.4:3000/api/payments/submit";
     
      

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token').toString();

      print("token:" + token);
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      var response = await http.put(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "phoneNumber": phoneNumberController.text,
            "fullName": fullNameController.text,
          }));
      print('StatusCode ${response.statusCode}: $url');
      if (response.statusCode == 200) {
       //fullName = loginArr['data']['user']['fullName'];
        prefs.remove('fullName');
        final keyFullName = 'fullName';
        final fullnameValue = fullNameController.text;
        prefs.setString(keyFullName, fullnameValue);
        Fluttertoast.showToast(
            msg: "Update success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      Get.to(HomePage());
      } else if (response.statusCode == 401) {
        print("Erro code 401: fail token: Invalid token signature");
      } else {
        print('response status code not 200');
      }
    } catch (e) {
      print(e);
    }

  }
}
