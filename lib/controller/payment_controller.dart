import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentController {
  Future<bool> submitPaymentMomo({
    required int amount,
    required int registrationId,
  }) async {
    try {
      String url = "${Constants.host}/api/payments";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token').toString();
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
           // "amount": amount,
            "paymentMethod": "Momo",
            "registrationId": registrationId,
          }));
      if (response.statusCode == 200) {
       
        Fluttertoast.showToast(
            msg: "Payment success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return true;
      } else if (response.statusCode == 401) {
        print("Erro code 401: fail token: Invalid token signature");
      } else {
        print('response status code not 200');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
