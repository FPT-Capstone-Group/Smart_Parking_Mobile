import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/apiEndpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentParkingOrderController {
  Future<bool> submitPaymentMomo({
    required String amount,
    required String transactionId,
     required String parkingOrderId,
  }) async {
    try {
    
      String url = "${ApiEndpoint.host}/api/payments/pay";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token').toString();
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "paymentAmount": amount,
            "paymentMethod": "Momo",
            "transactionId": transactionId,
            "parkingOrderId": parkingOrderId,
          }));

           print(response.statusCode.toString() + " url" + url.toString() );
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
         Fluttertoast.showToast(
            msg: "Payment fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
       Fluttertoast.showToast(
            msg: "Payment fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
