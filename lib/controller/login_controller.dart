import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future loginUser() async {
    const url = 'https://smart-parking-server-dev.azurewebsites.net/api/auth/local';

    try {
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }));
    if (response.statusCode == 200) {
      var loginArr = json.decode(response.body);
      // save this token in shared prefrences and make user logged in and navigate

      print(loginArr['token']);
    } else {
      
    }
     } catch (e) {
      print(e);
    }
  }
}