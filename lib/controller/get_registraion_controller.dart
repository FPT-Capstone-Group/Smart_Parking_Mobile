import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking_auto/constants.dart';
import 'package:parking_auto/model/registration_respone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetRegistraionController {
  var token;

  Future<List<Data>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token').toString();

    String url = "${Constants.host}/api/registrations";

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body)['data']['registrations'] as List;
      // print(jsonResponse);
      final x = jsonResponse.map((data) => Data.fromJson(data)).toList();
     x.sort((a, b) => b.registrationId!.compareTo(a.registrationId!));
      return x;
    } else {
      print("else != 200");
      throw Exception('Unexpected error occured!');
    }
  }
}

