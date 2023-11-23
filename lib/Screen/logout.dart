import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget  {
 
  const Logout({Key? key}) : super(key: key);

  @override
  _Logout createState() => _Logout();
}

class _Logout extends State<Logout>  {
  
  @override
  void initState() {
    super.initState();
    _removeToken();
  }

  _removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('token');
      prefs.remove('imagePath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginWithPhone(),
    );
  }
}