import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking_auto/apiEndpoint.dart';
import 'package:parking_auto/model/getUser_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserController {
  Future<List<Data>> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    String url = "${ApiEndpoint.host}/api/me";

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body)['data']['user'] as List;
      final x = jsonResponse.map((data) => Data.fromJson(data)).toList();
      return x;
    } else {
      print("else != 200");
      throw Exception('Unexpected error occured!');
    }
  }
}
