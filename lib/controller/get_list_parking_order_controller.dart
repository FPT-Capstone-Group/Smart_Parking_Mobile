import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:parking_auto/apiEndpoint.dart';
import 'package:parking_auto/model/listParkingOrder_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetListParkingOrderController {
  var bikeId;
  
  Future<List<Data>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var bikeId = prefs.getString('bikeId').toString();
 
   final queryParameters = {
        'bikeId': bikeId,
      };

        String url = "${ApiEndpoint.paramHost}";

        //for localhost
      // final uri = Uri.http(url, 'api/parkingOrders/getAllParkingOrdersByBike', queryParameters);

       //for https
       final uri = Uri.https(url, 'api/parkingOrders/getAllParkingOrdersByBike', queryParameters);
       print("url $uri");
       print("1");
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
     print("url $uri");
     print(response.statusCode);
    if (response.statusCode == 200) {
      prefs.remove("plateNumber");
      final jsonResponse = json.decode(response.body)['data']['parkingOrders'] as List;

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
