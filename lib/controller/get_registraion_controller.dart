import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:parking_auto/controller/login_controller.dart';
import 'package:parking_auto/model/registration_respone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetRegistraionController{
  var token;


   Future<List<Data>> fetchData() async {
    print("----------get_registration_data_page------------");
   SharedPreferences prefs = await SharedPreferences.getInstance();
    //getx update api data
    var token = prefs.getString('token').toString();
    print("token: "+ token);

    const url = 'http://localhost:3000/api/registrations/view';


  final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
  if (response.statusCode == 200) {
 
    List jsonResponse = json.decode(response.body);
   
    return jsonResponse.map((data) => Data.fromJson(data['data'])).toList();
  } else {
    print("else != 200");
    throw Exception('Unexpected error occured!');
  }
}

   getRegistraion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //getx update api data
    var token = prefs.getString('token').toString();
    try {
      const url = 'http://localhost:3000/api/registrations/view';
      //const url = 'http://192.168.0.11:3000/api/me';
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Get registrion successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Data.fromJson(data)).toList();
        // final Map<String, dynamic> parsed = json.decode(response.body);
        // print("----------get_current_user_page------------");
        // print("parsed[data]: ");
        // print(parsed['data']);
        // print("-------------------------------");

        // final data = Data.fromJson(parsed['data']);

        
        // // User? user;
        // // user = data.user;
        // // print("firstname: " + user!.firstName.toString());
        // // print("--------------------------");
      
        // Navigator.push(context,MaterialPageRoute(
        //         builder: (context) => MyproFile(), 
        //         settings: RouteSettings(
        //           arguments: user
        //         ))
        //   );

      } else if (response.statusCode == 401) {
        print("Erro code 401: fail token: Invalid token signature");
      } else {
        print('response status code not 200');
        throw jsonDecode(response.body)['meta']["message"] ??
            "Unknown Error Occured";
      }
    } catch (e) {
      print(e);
    }
  }
}

class GetDataTestController {
  var token;
  LoginController loginController = LoginController();

  Future<List<Data>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

  var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
}

