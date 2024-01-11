import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/User_Profile.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/apiEndpoint.dart';
import 'package:parking_auto/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ChangeNotifier {
 Data? user;
  bool loading = false;

  getPostData() async {
    loading = true;
    user = (await getUser())!;
    loading = false;

    notifyListeners();
  }

  updateData() async {
    loading = true;
    user = (await updateUser())!;
    loading = false;

    notifyListeners();
  }

  changePassword() async {
    loading = true;
    user = (await changePasswordUser())!;
    loading = false;

    notifyListeners();
  }

  forgotPassword() async {
    loading = true;
    user = (await forgotPasswordUser())!;
    loading = false;

    notifyListeners();
  }

  Future<Data?> getUser() async {
     Data? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    try {
      const url = '${ApiEndpoint.host}/api/me';
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
     print(response.statusCode.toString() + " url" + url.toString() );
      if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(response.body);
        final data = Data.fromJson(parsed['data']);
       
        user = data;
      } else if (response.statusCode == 401) {
        print("Erro code 401: fail token: Invalid token signature");
      } else {
        print('response status code not 200');
        throw jsonDecode(response.body)['meta']["message"] ??
            "Unknown Error Occured";
      }
    } catch (e) {
      log(e.toString());
    }
    return user;
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var dropGender;
  var gender;
  Data? result;
  int? age ;
  Future updateUser() async {
    
    try {
      if (dropGender == "Male") {
        gender = "Male";
      } else {
        gender = "FeMale";
      }

      String url = "${ApiEndpoint.host}/api/users/update";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token').toString();
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      var response = await http.put(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "gender": gender,
            "userFullName": fullNameController.text,
            "age": age,
            "address": addressController.text,
          }));
      if (response.statusCode == 200) {
        //fullName = loginArr['data']['user']['fullName'];
        prefs.remove('fullName');
        const keyFullName = 'fullName';
        final fullnameValue = fullNameController.text;
        prefs.setString(keyFullName, fullnameValue);

        // final Map<String, dynamic> parsed = json.decode(response.body);

        // final data = Data.fromJson(parsed['data']);
        // result = data;
        // print(result);
        Fluttertoast.showToast(
            msg: "Update success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.to(const UserProfile());
        // Get.to(HomePage());
      } else if (response.statusCode == 401) {
        print("Erro code 401: fail token: Invalid token signature");
      } else {
        print('response status code not 200');
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  Future changePasswordUser() async {
    try {
      String url = "${ApiEndpoint.host}/api/changePassword";

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
        Get.to(UserProfile());
      } else if (response.statusCode == 401) {
        print("Erro code 401: fail token: Invalid token signature");
      } else if (response.statusCode == 500) {
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
      log(e.toString());
    }
    return result;
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  var username;
  Future forgotPasswordUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    const url = "${ApiEndpoint.host}/pub/forgotPassword";
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "username": phoneController.text,
            "newPassword": passwordController.text,
            "otpToken": otpController.text,
          }));

      if (response.statusCode == 200) {
         Fluttertoast.showToast(
            msg: "You are set new password in successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        username = phoneController.text;
        prefs.remove('phoneCurrentRegister');
        final keyPhoneCurrentRegister = "phoneCurrentRegister";
        final valuePhoneCurrent = username;
        prefs.setString(keyPhoneCurrentRegister, valuePhoneCurrent);

        Get.to(LoginWithPhone(), );
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "Not found.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 500){
      
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }else{

      }
    } catch (e) {
      print(e);
    }
  }
}
