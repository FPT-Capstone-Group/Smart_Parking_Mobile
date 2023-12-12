import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/profilePage.dart';
import 'package:parking_auto/constants.dart';
import 'package:parking_auto/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserController extends GetxController {
  var fullName;
  var phoneNumber;
  User? user;
  var isLoading = false.obs;

  Future getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    try {
      const url = '${Constants.host}/api/me';
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        user = User.fromJson(result);
        final Map<String, dynamic> parsed = json.decode(response.body);

        final data = Data.fromJson(parsed['data']);

        fullName = data.user!.fullName.toString();
        phoneNumber = data.user!.username.toString();
        user = data.user!;

        prefs.remove('fullName');
        final keyFullName = 'fullName';
        final fullnameValue = fullName;
        prefs.setString(keyFullName, fullnameValue);

        Get.to(ProfilePage(), arguments: [
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
    } finally {
      isLoading(false);
    }
  }
}
