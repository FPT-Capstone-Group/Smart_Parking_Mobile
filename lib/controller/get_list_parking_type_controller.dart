import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:parking_auto/apiEndpoint.dart';
import 'package:parking_auto/model/listParkingType_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetListParkingTypeController {

  Future<List<Data>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
 
     String url = "${ApiEndpoint.host}/api/parkingTypes";

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
     print("url $url");
     print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body)['data']['parkingTypes'] as List;

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
