
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:parking_auto/Screen/face_camera.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOwnerController extends GetxController{

  callFaceCameraScreen(){
    Get.to(() => FaceCameraImage(), arguments: [
    {"type": 'addOwner'},
    {"second": 'Second data'}]);
  }

  TextEditingController faceImagePath = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  var dropValue ;
  int? feeId;
  
  //String? imagePath;
  var token;
  Future addOwner() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    var imagePath = prefs.getString('imagePath').toString();

    //localhost test api
    //String url = "http://localhost:3000/api/registrations/create";

    // mobile test localhost android emulator
    //String urlLocalhost = "http://192.168.1.3:3000/api/registrations/create";

    // wifi test localhost mobile real
    String urlLocalhost = "http://192.168.0.4:3000/api/registrations/addOnwer";

    var request = new http.MultipartRequest("POST", Uri.parse(urlLocalhost));
    request.headers['Authorization'] = 'Bearer $token';
    //request.headers['Content-Type'] ='multipart/form-data';

    // if(dropValue.toString() == "One Month"){
    //     feeId=1;
    // }else{
    //     feeId=1;
    // }
    request.fields['feeId'] = feeId.toString();
    print('feeid: '+ feeId.toString());
    request.fields['plateNumber'] = plateNumberController.text;
    request.fields['relationship'] = relationshipController.text;
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
      print("------------------addOwner-------------");
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "AddOnwer successfull",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.to(HomePage(),);
      } else {
        print(response.statusCode);
      }

      //SpellRoot spellRoot=spellRootFromJson(respString);
    } catch (e, s) {
      print("ERRR 200 responsecode");
      print("$e __ $s");
    }
  }
}
