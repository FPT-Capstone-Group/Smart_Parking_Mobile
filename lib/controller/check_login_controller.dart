
import 'package:get/get.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLogin {
  var phoneCurrent;
    Future<void> checkLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      phoneCurrent = prefs.getString("phoneCurrent");
      if(phoneCurrent != null){
        Get.to(HomePage());
      }else{
        Get.to(LoginWithPhone());
      }

    }

}