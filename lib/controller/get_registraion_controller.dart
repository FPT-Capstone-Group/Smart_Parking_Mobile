import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking_auto/model/registration_respone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetRegistraionController {
  var token;

  Future<List<Data>> fetchData() async {
    print("----------get_registration_data_page------------");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //getx update api data
    var token = prefs.getString('token').toString();

    //const url = '${Constants.host}/api/registrations/view';
    //const url = 'http://localhost:3000/api/registrations';

    //wifi localhost test real mobile
    //String url = "http://192.168.0.4:3000/api/registrations";
    String url = "http://10.233.1.65:3000/api/registrations";

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    print("response: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body)['data'] as List;
      // print(jsonResponse);
      final x = jsonResponse.map((data) => Data.fromJson(data)).toList();
      return x;
    } else {
      print("else != 200");
      throw Exception('Unexpected error occured!');
    }
  }
}

