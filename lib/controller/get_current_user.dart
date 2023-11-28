import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/my_profile.dart';
import 'package:parking_auto/model/user.dart';
//import 'package:parking_auto/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserController extends GetxController {
  var fullName;
  var phoneNumber;
  User? user;
  var isLoading = false.obs;
  
  @override
  Future<void> onInit() async {
    super.onInit();
    getUserData();
  }

  Future getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //getx update api data
    var token = prefs.getString('token').toString();
    try {
      const url = 'http://localhost:3000/api/me';
      //const url = 'http://192.168.0.11:3000/api/me';
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        // var result = jsonDecode(response.body);

        // user = User.fromJson(result['data']);
        
         final Map<String, dynamic> parsed = json.decode(response.body);
         print("----------get_current_user_page------------");
        // print("parsed[data]: ");
        // print(parsed['data']);
        // print("-------------------------------");
        // var loginArr = json.decode(response.body);
        // fullName = loginArr['data']['user']['fullName'];
        // phoneNumber =  loginArr['data']['user']['phoneNumber'];

        final data = Data.fromJson(parsed['data']);

        Fluttertoast.showToast(
            msg: "Get user successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
       // fullName = data.user!.fullName.toString();
       // phoneNumber = data.user!.phoneNumber.toString();
        // User user;
         user = data.user!;
         print("full name: " + user!.fullName.toString());
        // print("fullName: " + user.fullName.toString());
        // print("--------------------------");
        // print("user");
        // print(user);
      
        // Navigator.push(context,MaterialPageRoute(
        //         builder: (context) => MyproFile(), 
        //         settings: RouteSettings(
        //           arguments: user
        //         ))
        //   );
      
        Get.to(MyProFile());
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
