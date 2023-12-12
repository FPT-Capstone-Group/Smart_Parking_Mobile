
import 'package:get/get.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLogin {
  var loginSession;
    Future<void> checkLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      loginSession = prefs.getString("loginSession");
     print("loginsession : $loginSession");
      if(loginSession == "true"){
         Get.to(const HomePage());
      }

    }
}