import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/constants.dart';
import 'package:parking_auto/model/parking_session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParkingSessionController extends GetxController{
  var plateNumberController;

   Future<List<Data>> fetchData() async {
 
 SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var plateNumberController = prefs.getString('plateNumber').toString();
       String url = "${Constants.host}/api/parking";

     Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "plateNumber": plateNumberController,
          }));
  if (response.statusCode == 200) {

    final jsonResponse = json.decode(response.body)['data']['parking'] as List;
    
   final x = jsonResponse.map((data) => Data.fromJson(data)).toList();
      return x;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Owner');
  }

  }

}
