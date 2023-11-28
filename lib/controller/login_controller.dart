import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{
  
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var strtoken;
  var phoneCurrent;
  var phoneNumber;
  var fullName;
  //User? user;


  Future loginUser() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    //const url = 'https://smart-parking-server-dev.azurewebsites.net/api/auth/local';

    //const url = '${Constants.host}/pub/login';


    //const url = 'http://localhost:3000/pub/login';

    // mobile test localhost emulator
    //String url = "http://192.168.1.1:3000/pub/login";

    //wifi localhost test real mobile
    //String url = "http://192.168.0.4:3000/pub/login";
    //String url = "http://10.233.1.65:3000/pub/login";
    //10.233.1.65

      const url = "https://server.smartparking.site/pub/login";
     //const url = "https://file.hungtuan.me/pub/login";
  
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "phoneNumber": phoneNumberController.text,
            "password": passwordController.text,
          }));

      if (response.statusCode == 200) {
        var loginArr = json.decode(response.body);
        //fullName = loginArr['data']['user']['fullName'];
        phoneNumber =  loginArr['data']['user']['phoneNumber'];
        //final data = Data.fromJson(loginArr['data']);
        //user = data.user;
        // print("--fullname");
        // print(user!.fullName.toString());
        strtoken = loginArr['data']['token'];

        //save token
        prefs.remove('token');
        final keyToken = 'token';
        final valueToken = strtoken;
        prefs.setString(keyToken, valueToken);

         //save fullName
        // prefs.remove('fullName');
        // final keyFullName = 'fullName';
        // final fullnameValue = fullName;
        // prefs.setString(keyFullName, fullnameValue);

        //save phone login current
        phoneCurrent = loginArr['data']['user']['phoneNumber'];
        final keyPhoneCurrent = 'phoneCurrent';
        final valuePhoneCurrent = phoneCurrent;
        prefs.setString(keyPhoneCurrent, valuePhoneCurrent);
        print("--login");
        print("phoneCurrent :" +phoneCurrent.toString());

        
        Fluttertoast.showToast(
            msg: "You are login successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

            Get.to(HomePage(),);
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => HomePage(),
        // ));
      } else {
        Fluttertoast.showToast(
            msg: "Invalid phone or password",
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
