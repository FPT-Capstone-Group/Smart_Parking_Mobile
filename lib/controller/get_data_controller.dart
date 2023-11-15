import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking_auto/controller/login_controller.dart';
import 'package:parking_auto/model/reistraion_model.dart';

class GetDataController {
  var token;
  LoginController loginController = LoginController();

  Future<List<Data>> fetchData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
}

