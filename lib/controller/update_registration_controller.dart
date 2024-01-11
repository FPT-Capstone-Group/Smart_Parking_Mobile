import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:parking_auto/apiEndpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateRegistrationController {
  var plateNumberController;
  
  Future reactive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var registrationId  = prefs.getString('registrationId').toString();

   final queryParameters = {
        'registrationId': registrationId,
      };
      //final uri = Uri.https('smart-parking-server-dev.azurewebsites.net', 'api/owners', queryParameters);

       final uri = Uri.http('smart-parking-server-dev.azurewebsites.net', 'api/registrations/reactive', queryParameters);
        print("uri: $uri");
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
     
        print("uri: $uri");
        print(response.statusCode);
    if (response.statusCode == 200) {
      prefs.remove("registrationId");
      Fluttertoast.showToast(
              msg: "Reactive successfully.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
              msg: "Reactive successfully.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
      throw Exception('Failed to load Owner');
    }
  }

  Future deactiveTempo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var registrationId  = prefs.getString('registrationId').toString();

   final queryParameters = {
        'registrationId': registrationId,
      };
      print("vao");
      //final uri = Uri.https('smart-parking-server-dev.azurewebsites.net', 'api/owners', queryParameters);

       final uri = Uri.http('smart-parking-server-dev.azurewebsites.net', 'api/registrations/deactive/', queryParameters);
        print("test");
        print("uri: $uri");
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      print("trong");
        print("uri: $uri");
        print(response.statusCode);
    if (response.statusCode == 200) {
      prefs.remove("registrationId");
       Fluttertoast.showToast(
              msg: "Deactive successfully.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

     
    } else {
      Fluttertoast.showToast(
              msg: "Deactive fail.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
      throw Exception('Failed to load Owner');
    }
  }
   Future cancelRegistration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var registrationId = prefs.getString('registrationId').toString();
    try {

      final queryParameters = {
        'registrationId': registrationId,
      };
      String url = "${ApiEndpoint.paramHost}";
      final uri = Uri.https(url, '/api/registrations/cancel/:', queryParameters);
      final response = await http.put(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
        print("uri: $uri");
      
      if ( response.statusCode == 200) {
        prefs.remove("registrationId");
        Fluttertoast.showToast(
            msg: "Registration canceled successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
            
            Get.to(RegistrationHistory());
      } else if( response.statusCode == 404){
        print(response.statusCode);
        Fluttertoast.showToast(
            msg: "Registration not found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }else if( response.statusCode == 400){
        print(response.statusCode);
        Fluttertoast.showToast(
            msg: "Registration cannot be canceled in paid or active status",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }else if( response.statusCode == 500){
        print(response.statusCode);
        Fluttertoast.showToast(
            msg: "Internal Server Error",
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
