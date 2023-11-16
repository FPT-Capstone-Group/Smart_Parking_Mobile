import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetUserController extends GetxController {
  
  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //getx update api data
    var token = prefs.getString('token').toString();
        print(token);
    try {
    const url = 'http://localhost:3000/api/me';
     var response = await http.get(Uri.parse(url), headers: {
     //'Content-Type': 'application/json',
      //'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

      print("status code: "+ response.statusCode.toString());
      if (response.statusCode == 200) {
        //var Userdata = json.decode(response.body);
         Fluttertoast.showToast(
          msg: "Get data successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      } else if(response.statusCode == 401){
        print("Erro code 401: fail token: Invalid token signature");
      } else{
        print('response status code not 200');
        throw jsonDecode(response.body)['meta']["message"] ??
            "Unknown Error Occured";
      }
    } catch (e) {
      print(e);
    }
  }
}