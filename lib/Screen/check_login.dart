import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});


  @override
  State<CheckLogin> createState() => _CheckLogin();
}

class _CheckLogin extends State<CheckLogin> {

    @override
  void initState() {
    super.initState();
    checkLogin();
  }
   Future<void> checkLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var loginSession = prefs.getString("loginSession");
     print("loginsession : $loginSession");
      if(loginSession == "true"){
         Get.to(const HomePage());
      }else{
        Get.to(const LoginWithPhone());
      }

    }

  @override
  Widget build(BuildContext context) => Scaffold(
     
        appBar: AppBar(
          title: Text('Check Login'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
      );
}