import 'dart:convert';
import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/create_registration.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/registration_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FaceCameraRegistration extends StatefulWidget {
  const FaceCameraRegistration({Key? key}) : super(key: key);
  @override
  _FaceCamera createState() => _FaceCamera();
}

class _FaceCamera extends State<FaceCameraRegistration> {
  dynamic argumentData = Get.arguments;
  RegistrationController registrationBike = RegistrationController();
  File? _capturedImage;
  var imgPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Face Image'),
          centerTitle: true,
           leading: IconButton(
          onPressed: () {
            Get.to(HomeNavBar());
          },
          icon: const Icon(Icons.home),
        ),
        ),
        body: Builder(builder: (context) {
          if (_capturedImage != null) {
            return Center(
              child: Column(
                // alignment: Alignment.bottomCenter,
                children: [
                  Image.file(
                    _capturedImage!,
                    width: double.maxFinite,
                    fit: BoxFit.fitWidth,
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      setState(() => _capturedImage = null);
                    },
                    // icon: Icon(Icons.reset_tv_sharp),
                    label: const Text('Capture Again'),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Get.to(
                        () => Registration(),
                      );
                    },
                    //icon: Icon(Icons.next_plan),
                    label: const Text('Next'),
                  ),
                ],
              ),
            );
          }
          return SmartFaceCamera(
              autoCapture: true,
              defaultCameraLens: CameraLens.front,
              onCapture: (File? image) async {
                setState(() => _capturedImage = image);
                imgPath = image!.path;
                //registrationBike.imagePath = imgPath;
                Fluttertoast.showToast(
                    msg: "capture sucessfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 12.0);
                //save image path
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('imagePath');
                prefs.setString('imagePath', imgPath);

                // print(imgPath);

                Future<String> imto64(File image) async {
                  List<int> imgByte = await image.readAsBytes();
                  String base64 = base64Encode(imgByte);
                  // print(base64);

                  return base64;
                }

                imto64(image);
              },
              onFaceDetected: (Face? face) {
                //Do something
              },
              messageBuilder: (context, face) {
                if (face == null) {
                  return _message('Place your face in the camera');
                }
                if (!face.wellPositioned) {
                  return _message('Center your face in the square');
                }
                return const SizedBox.shrink();
              });
        }));
  }

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
      );
}
