import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/apiEndpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateOrderController {
 Future createOrder() async {
    try {
     
      String url = "${ApiEndpoint.host}/api/parkingOrders/create";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token').toString();
      var bikeId = prefs.getString('bikeId').toString();
      var parkingTypeId = prefs.getString('parkingTypeId').toString();
      var expiredDate = prefs.getString('expiredDate').toString();
      var parkingOrderAmount = prefs.getString('parkingOrderAmount').toString();

      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      };
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            "bikeId": bikeId,
            "parkingTypeId": parkingTypeId,
            "expiredDate": expiredDate,
            "parkingOrderAmount": parkingOrderAmount,
          }));

           print(response.statusCode.toString() + " url" + url.toString() );
      if (response.statusCode == 200) {
       
        Fluttertoast.showToast(
            msg: "Create Order Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      
      } else if (response.statusCode == 401) {
          Fluttertoast.showToast(
            msg: "Create Order Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Erro code 401: fail token: Invalid token signature");
      } else {
          Fluttertoast.showToast(
            msg: "Create Order Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print('response status code not 200');
      }
    } catch (e) {
      print(e);
    }
   
  }
}
