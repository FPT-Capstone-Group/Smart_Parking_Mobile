import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:parking_auto/apiEndpoint.dart';
import 'package:parking_auto/model/listBike_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetListBikeController {
  Future<List<Data>> getListBikeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    String url = "${ApiEndpoint.host}/api/bikes";

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body)['data']['bikes'] as List;
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
