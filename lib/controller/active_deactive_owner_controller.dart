import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/bike_of_user.dart';
import 'package:parking_auto/apiEndpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveDeactiveOwnerController {
  Future activeOwner() async {
    try {
      String url = "${ApiEndpoint.host}/api/owners/activate";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token').toString();
      var ownerId = prefs.getString('ownerId').toString();
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "ownerId": ownerId.toString(),
          }));
       //print('StatusCode ${response.statusCode}: $url');
      if (response.statusCode == 200) {
        prefs.remove("ownerId");
        Fluttertoast.showToast(
            msg: "Active Owner Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
         Get.to(const BikeOfUser());
      }else if (response.statusCode == 201) {
        prefs.remove("ownerId");
        Fluttertoast.showToast(
            msg: "Active Owner Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.to(const BikeOfUser());
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Invalid token signature",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Active Owner Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Active Owner Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
     // print(e);
    }
  }

   Future deactiveOwner() async {
    try {
      String url = "${ApiEndpoint.host}/api/owners/deactivate";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token').toString();
      var ownerId = prefs.getString('ownerId').toString();
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "ownerId": ownerId.toString(),
          }));
      // print('StatusCode ${response.statusCode}: $url');
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Deactive Owner Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.to(const BikeOfUser());
      } else if (response.statusCode == 201) {
        Fluttertoast.showToast(
            msg: "Deactive Owner Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
         Get.to(const BikeOfUser());
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Deactive Owner Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Deactive Owner Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
     // print(e);
    }
  }
}
