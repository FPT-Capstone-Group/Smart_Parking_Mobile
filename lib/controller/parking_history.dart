import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/model/parking_session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParkingSessionController extends GetxController{
  var plateNumberController;

   Future<List<Data>> fetchData() async {
 
 SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var plateNumberController = prefs.getString('plateNumber').toString();

       final queryParameters = {
        'plateNumber': plateNumberController,
      };
      
     // final uri = Uri.http('localhost:3000', '/api/registrations/cancel', queryParameters);
      final uri = Uri.https('smart-parking-server-dev.azurewebsites.net', '/api/sessions/', queryParameters);
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      // print("uri $uri");
      // print(response.statusCode);
  if (response.statusCode == 200) {
    

    final jsonResponse = json.decode(response.body)['data']['parkingSessions'] as List;
   final x = jsonResponse.map((data) => Data.fromJson(data)).toList();
    x.sort((a, b) => b.parkingSessionId!.compareTo(a.parkingSessionId!));
      return x;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Owner');
  }

  }

}
