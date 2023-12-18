import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:parking_auto/model/list_notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetListNotiController{

   Future<List<Data>> getListNoti() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var userId = prefs.getString('userId').toString();

    final queryParameters = {
        'userId': userId,
      };

      final uri = Uri.https('smart-parking-server-dev.azurewebsites.net', 'api/notifi', queryParameters);
       //final uri = Uri.http('localhost:3000', 'api/notifi', queryParameters);
       
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      print("uri: $uri");
        print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body)['data']['notifications'] as List;
      final x = jsonResponse.map((data) => Data.fromJson(data)).toList();
      //x.sort((a, b) => b.bikeId!.compareTo(a.bikeId!));
      x.sort((a,b) => DateFormat("yyyy-MM-dd hh:mm:ss").parse(b.updatedAt!).compareTo(DateFormat("yyyy-MM-dd hh:mm:ss").parse(a.updatedAt!)));
      return x;
    } else {
      print("else != 200");
      throw Exception('Unexpected error occured!');
    }
  }
}