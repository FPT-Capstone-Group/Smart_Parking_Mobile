import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOwnerController extends GetxController{
  TextEditingController fullNameController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  var dropGender;
  var gender;
  Future addOwner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var imageBase64 = prefs.getString('imageBase64').toString();
    try {

      String url = "${Constants.host}/api/owners/create/";
      print("drop gender: "+ dropGender);
      if (dropGender == "Male") {
           gender = "Male";
        } else {
          gender = "FeMale";
        }
    
      Map<String, String> headers = {
         "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "fullName": fullNameController.text,
            "plateNumber": plateNumberController.text,
            "ownerFaceImage": imageBase64,
            "relationship": relationshipController.text,
            "gender": gender,
          }));
      final Map<String, dynamic> parsed = json.decode(response.body);

        //final data = Data.fromJson(parsed);
        var code =  parsed['code'];
      
      if ( code.toString() == "201") {
      
        Fluttertoast.showToast(
            msg: "Add owner success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
            
            Get.to(HomePage());
      } else {
        Fluttertoast.showToast(
            msg: "Add owner fail",
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
