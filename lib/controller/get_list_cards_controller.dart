import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:parking_auto/model/listCards_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetListCardsController {
  var bikeId;
  
  Future<List<Cards>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var bikeId = prefs.getString('bikeId').toString();

   final queryParameters = {
        'bikeId': bikeId,
      };
   
      //final uri = Uri.https('smart-parking-server-dev.azurewebsites.net', 'api/owners', queryParameters);

       final uri = Uri.https('smart-parking-server-dev.azurewebsites.net', 'api/bikes/getAllCardsByBikeId', queryParameters);
       
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
     
        print("uri: $uri");
        print(response.statusCode);
    if (response.statusCode == 200) {
      prefs.remove("plateNumber");
      final jsonResponse = json.decode(response.body)['data'] as List;

      final x = jsonResponse.map((data) => Cards.fromJson(data)).toList();
      return x;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Owner');
    }
  }
}
