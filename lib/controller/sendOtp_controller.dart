import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/apiEndpoint.dart';

class SendOtpController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
 
  Future sendOtp() async {
    
    const url = "${ApiEndpoint.host}/pub/otp/send";
    
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "username": phoneNumberController.text,
          }));
        print("phone: " + phoneNumberController.text);
      if (response.statusCode == 200) {
    
        Fluttertoast.showToast(
            msg: "Send otp successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

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
            msg: "Send otp error.",
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
