import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/model/user_model.dart';

class UserController extends GetxController {
  UserModel? userModel;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  fetchUserData(String userid) async {
    //getx fetch api data
    var token =
        'YOUR_TOKEN';
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      http.Response response = await http.get(
          Uri.tryParse('{{host}}/api/me /${userid}')!,
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
        userModel = UserModel.fromJson(result);
        firstNameController.text = result['firstName'];
        lastNameController.text = result['lastName'];
        phoneNumberController.text = result['phoneNumber'];
        
        //do any task
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('error $e');
    }
  }

  updateUserData(String userid) async {
    //getx update api data
    var token =
        'YOUR_TOKEN';
    try {
      var body = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'phoneNumber': phoneNumberController.text,
      };

      http.Response response = await http.put(
        Uri.parse('{{host}}/api/me/$userid'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('data updated');
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

  deleteUserData(String userid) async {
    //getx delete api data
    var token =
        'YOUR_TOKEN';
    try {
      http.Response response = await http.delete(
        Uri.parse('{{host}}/api/me/$userid'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 204) {
        // final json = jsonDecode(response.body);
        // delete success, do anything
        print('deleted user $userid');
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