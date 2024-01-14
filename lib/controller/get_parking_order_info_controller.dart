import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/Screen/bike_of_user.dart';
import 'package:parking_auto/apiEndpoint.dart';
import 'package:parking_auto/model/parkingOrderInfo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetParkingOrderInfoController extends ChangeNotifier {
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
    var bikeId = prefs.getString('bikeId').toString();
    var parkingTypeId = prefs.getString('parkingTypeId').toString(); 
    // print(parkingTypeId);
    // print(bikeId);
    try {
       final queryParameters = {
        'bikeId': bikeId,
        'parkingTypeId': parkingTypeId
      };
   

       String url = "${ApiEndpoint.paramHost}";
        //localhost
       //final uri = Uri.http(url, 'api/parkingOrders/getParkingOrderInfo', queryParameters);

        // for https
       final uri = Uri.https(url, 'api/parkingOrders/getParkingOrderInfo', queryParameters);
       
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
 
     //print(response.statusCode.toString() + " url" + uri.toString() );
      if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(response.body);
      //print(parsed);
        final data = Data.fromJson(parsed['data']);
 
        user = data;
    //print(user.bikeId);
      } else if (response.statusCode == 400) {
         Fluttertoast.showToast(
              msg: "Cannot create parking order. The bike already has an active or pending parking order",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        
        Get.to(
             const BikeOfUser(),
          );
       // print("Erro code 401: fail token: Invalid token signature");
      } else if (response.statusCode == 401) {
         Fluttertoast.showToast(
              msg: "Cannot create parking order. The bike already has an active or pending parking order",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        
         Get.to(
            const BikeOfUser(),
          );
       // print("Erro code 401: fail token: Invalid token signature");
      }else {
         Fluttertoast.showToast(
              msg: "Cannot create parking order. The bike already has an active or pending parking order",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        
         Get.to(
           const  BikeOfUser(),
          );
        //print('response status code not 200');
        throw jsonDecode(response.body)['meta']["message"] ??
            "Unknown Error Occured";
      }
    } catch (e) {
      log(e.toString());
    }
    return user;
  }

 

}
