import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationBike {
  TextEditingController faceImagePath = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  var dropValue ;
  int? feeId;
  
  //String? imagePath;
  var token;
  Future registrion(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    var imagePath = prefs.getString('imagePath').toString();

    //localhost test api
    //String url = "http://localhost:3000/api/registrations/create";

    // mobile test localhost android emulator
    //String urlLocalhost = "http://192.168.1.3:3000/api/registrations/create";

    // wifi test localhost mobile real
   // String urlLocalhost = "http://192.168.0.4:3000/api/registrations/create";

    const url = "https://server.smartparking.site/api/registrations/create";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';
    //request.headers['Content-Type'] ='multipart/form-data';

    if(dropValue.toString() == "One Month"){
        feeId=1;
    }else{
        feeId=1;
    }
    request.fields['feeId'] = feeId.toString();
    print('feeid: '+ feeId.toString());
    request.fields['plateNumber'] = plateNumberController.text;
    request.files.add(await http.MultipartFile.fromPath(
      'faceImage',
      imagePath.toString(),
      contentType: new MediaType('image', 'jpg'),
    ));

    try {
      var response = await request.send();
      var res = await http.Response.fromStream(response);

      //final Map<String, dynamic> parsed = json.decode(res.body);

      prefs.remove('imagePath');
      print("-------------------------------");
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Registration successfull",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
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

      //SpellRoot spellRoot=spellRootFromJson(respString);
    } catch (e, s) {
      print("ERRR 200 responsecode");
      print("$e __ $s");
    }
  }
}
