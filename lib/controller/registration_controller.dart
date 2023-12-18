import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/apiEndpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController {
  TextEditingController faceImagePath = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();
  TextEditingController modelBikeController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();

  //var dropFee;
  var dropGender;
  var gender;
  var feeName;

  //String? imagePath;
  var token;
  Future create(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    var imagePath = prefs.getString('imagePath').toString();

    const url = "${ApiEndpoint.host}/api/registrations/create";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';
    //request.headers['Content-Type'] ='multipart/form-data';

    // if (dropFee.toString() == "One Month") {
    //   feeName = "resident";
    // } else {
    //   feeName = "resident";
    // }

    if (dropGender.toString() == "Male") {
      gender = "Male";
    } else {
       gender = "FeMale";
    }
    
    request.files.add(await http.MultipartFile.fromPath(
      'faceImage',
      imagePath.toString(),
      contentType: new MediaType('image', 'jpg'),
    ));
    request.fields['plateNumber'] = plateNumberController.text;
    //request.fields['feeName'] = feeName.toString();
    request.fields['manufacture'] = manufactureController.text;
    request.fields['model'] = modelBikeController.text;
    request.fields['registrationNumber'] = registrationNumberController.text.toUpperCase();
    request.fields['gender'] = gender;
    try {
      var response = await request.send();
      var res = await http.Response.fromStream(response);

      //final Map<String, dynamic> parsed = json.decode(res.body);

      prefs.remove('imagePath');
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Registration successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      } else if (res.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "Not found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Registration fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print(response.statusCode);
      }

    } catch (e, s) {
      print("ERRR 200 responsecode");
      print("$e __ $s");
    }
  }
}
