import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CancelRegistrationController{
  Future cancelRegistration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var registrationId = prefs.getString('registrationId').toString();
    try {

      final queryParameters = {
        'registrationId': registrationId,
      };
      
      final uri = Uri.https('smart-parking-server-dev.azurewebsites.net', '/api/registrations/cancel/:', queryParameters);
      final response = await http.put(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
        print("uri: $uri");
      
      if ( response.statusCode == 200) {
        prefs.remove("registrationId");
        Fluttertoast.showToast(
            msg: "Cancel registration success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
            
            Get.to(RegistrationHistory());
      } else {
        print(response.statusCode);
        Fluttertoast.showToast(
            msg: "Cancel registration fail",
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
