import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/constants.dart';
import 'package:parking_auto/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  User? user;
  var isLoading = false.obs;

  getU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    try {
      const url = '${Constants.host}/api/me';
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        print("uer-profile-");
        final Map<String, dynamic> parsed = json.decode(response.body);
        final data = Data.fromJson(parsed['data']);
        user = data.user!;
        print(user!.fullName.toString());

      //  Get.to(GetUPage());
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
