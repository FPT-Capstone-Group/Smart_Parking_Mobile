import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/profilePage.dart';
import 'package:parking_auto/constants.dart';
import 'package:parking_auto/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserController extends GetxController {
  var fullName;
  var phoneNumber;
  User? user;
  var isLoading = false.obs;
  
  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   getUserData();
  // }

  Future getUserData() async {
    print("getUser controller");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //getx update api data
    var token = prefs.getString('token').toString();
    try {
      const url = '${Constants.host}/api/me';
      //const url = 'http://192.168.0.11:3000/api/me';
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        print("uer-profile-");
         var result = jsonDecode(response.body);
        print(result);
          user = User.fromJson(result);
          print(user);
        print("uer-profile-");

         final Map<String, dynamic> parsed = json.decode(response.body);

        final data = Data.fromJson(parsed['data']);

        Fluttertoast.showToast(
            msg: "Get user successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        fullName = data.user!.fullName.toString();
        phoneNumber = data.user!.username.toString();

        // User user;
         user = data.user!;
         print("full name: " + fullName);
         print("phone: " + phoneNumber);
       
      
       Get.to(ProfilePage(),arguments: [
    {"fullname": fullName},
    {"phone": phoneNumber}
]);
      } else if (response.statusCode == 401) {
        print("Erro code 401: fail token: Invalid token signature");
      } else {
        print('response status code not 200');
        throw jsonDecode(response.body)['meta']["message"] ??
            "Unknown Error Occured";
      }
    } catch (e) {
      print(e);
    }finally {
      isLoading(false);
    }
  }

  
}
