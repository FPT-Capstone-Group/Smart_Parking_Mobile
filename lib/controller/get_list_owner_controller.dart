import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:parking_auto/apiEndpoint.dart';
import 'package:parking_auto/model/listOwner_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetListOwnerController {
  var plateNumberController;
  
  Future<List<Data>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var plateNumberController = prefs.getString('plateNumber').toString();

   final queryParameters = {
        'plateNumber': plateNumberController,
      };
   
      //final uri = Uri.https('smart-parking-server-dev.azurewebsites.net', 'api/owners', queryParameters);

        String url = "${ApiEndpoint.paramHost}";


       final uri = Uri.https(url, 'api/owners', queryParameters);
       
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
     
        // print("uri: $uri");
        // print(response.statusCode);
    if (response.statusCode == 200) {
      prefs.remove("plateNumber");
      final jsonResponse = json.decode(response.body)['data']['owners'] as List;

      final x = jsonResponse.map((data) => Data.fromJson(data)).toList();
      //x.sort((a, b) => b.ownerId!.compareTo(a.ownerId!));
      x.sort((a,b) => DateFormat("yyyy-MM-dd hh:mm:ss").parse(b.updatedAt!).compareTo(DateFormat("yyyy-MM-dd hh:mm:ss").parse(a.updatedAt!)));
      return x;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Owner');
    }
  }
}
