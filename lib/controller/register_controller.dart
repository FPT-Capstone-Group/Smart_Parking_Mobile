import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/home.dart';

class RegisterController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future registerUser(BuildContext context) async {
    const url =
        'https://smart-parking-server-dev.azurewebsites.net/api/auth/local/register';

    Map<String, String> headers = {
      "Content-type": "application/json"
      };
    var response = await http.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode({
          'username': usernameController.text,
          'email': emailController.text,
          'PhoneNumber': phoneController.text,
          'password': passwordController.text,
        }));

    if (response.statusCode == 200) {
      var registerArr = json.decode(response.body);
      // save this token in shared prefrences
      //to do

      Fluttertoast.showToast(
          msg: "You are register in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print("token:" + registerArr['jwt']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
          msg: "Email or Username are already taken",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {}
  }
}
