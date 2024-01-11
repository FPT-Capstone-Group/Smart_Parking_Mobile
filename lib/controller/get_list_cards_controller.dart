import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/apiEndpoint.dart';
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

       String url = "${ApiEndpoint.paramHost}";

       final uri = Uri.https(url, 'api/bikes/getAllCardsByBikeId', queryParameters);
       
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
     
       // print("uri: $uri");
       // print(response.statusCode);
    if (response.statusCode == 200) {
      prefs.remove("plateNumber");
      final jsonResponse = json.decode(response.body)['data'] as List;

      final x = jsonResponse.map((data) => Cards.fromJson(data)).toList();
      return x;
    }else if (response.statusCode == 404) {
       Fluttertoast.showToast(
            msg: "No Cards",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
             throw Exception('No Cards');
    } else if (response.statusCode == 500) {
       Fluttertoast.showToast(
            msg: "Internal Server Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
             throw Exception('Internal Server Error');
    }  else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to list cards');
    }
  }
}
