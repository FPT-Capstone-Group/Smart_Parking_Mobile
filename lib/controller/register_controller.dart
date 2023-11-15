import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/home.dart';

class RegisterController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future registerUser(BuildContext context) async {

    print("firstname : " + firstNameController.text);
    print("lasttname : " + lastNameController.text);
    print("phone : " + phoneController.text);
    print("password : " + passwordController.text);
    //const url ='https://smart-parking-server-dev.azurewebsites.net/api/auth/local/register';
    const url = 'localhost:3000/pub/register';
    Map<String, String> headers = {
      "Content-type": "application/json"
      };
    var response = await http.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode({
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'phoneNumber': phoneController.text,
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
          msg: "User already exists with same phoneNumber",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {

    }
  }
}
