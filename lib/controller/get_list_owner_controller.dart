import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking_auto/constants.dart';
import 'package:parking_auto/model/listOwner_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetListOwnerController {
  var plateNumberController;

  Future<List<Data>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    var plateNumberController = prefs.getString('plateNumber').toString();

    String url = "${Constants.host}/api/owners";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var response = await http.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode({
          "plateNumber": plateNumberController.toString(),
        }));
    if (response.statusCode == 200) {
      prefs.remove("plateNumber");
      final jsonResponse = json.decode(response.body)['data']['owners'] as List;

      final x = jsonResponse.map((data) => Data.fromJson(data)).toList();
      x.sort((a, b) => b.ownerId!.compareTo(a.ownerId!));
      return x;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Owner');
    }
  }
}
