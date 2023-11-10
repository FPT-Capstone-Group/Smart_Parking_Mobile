import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  //UserModel? userModel;
  TextEditingController approvedByController = TextEditingController();
  TextEditingController faceImageController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  //TextEditingController statusController = TextEditingController();

  updateUserData(String userid) async {
    //getx update api data
    var token =
        'YOUR_TOKEN';
    try {
      var body = {
        'name': approvedByController.text,
        'email': faceImageController.text,
        'gender': plateNumberController.text
        //'status': statusController.text,
      };

      http.Response response = await http.put(
        Uri.parse('https://smart-parking-server-dev.azurewebsites.net/api/registrations'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        
      Fluttertoast.showToast(
          msg: "Registration successfull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
        print(json);
      } else {
        print('response status code not 200');
        throw jsonDecode(response.body)['meta']["message"] ??
            "Unknown Error Occured";
      }
    } catch (e) {
      print(e);
    }
  }
}