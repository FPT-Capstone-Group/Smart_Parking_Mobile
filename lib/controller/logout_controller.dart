
import 'package:get/get.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {

  logout() async {
   
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('imagePath');
      prefs.remove("loginSession");
   Get.to(const LoginWithPhone());
    
  }
}