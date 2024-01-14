import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/apiEndpoint.dart';
import 'package:parking_auto/model/parkingOrderInfo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageOrderInfoController extends ChangeNotifier {
 Data? user;
  bool loading = false;

  getPostData() async {
    loading = true;
    user = (await getData())!;
    loading = false;

    notifyListeners();
  }

  Future<Data?> getData() async {
     Data? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();
    try {
      const url = '${ApiEndpoint.host}/api/me';
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
    // print(response.statusCode.toString() + " url" + url.toString() );
      if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(response.body);
        final data = Data.fromJson(parsed['data']);
       
        user = data;
      } else if (response.statusCode == 401) {
        print("Erro code 401: fail token: Invalid token signature");
      } else {
        print('response status code not 200');
        throw jsonDecode(response.body)['meta']["message"] ??
            "Unknown Error Occured";
      }
    } catch (e) {
      log(e.toString());
    }
    return user;
  }

}
