import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking_auto/Screen/registration.dart';


class FaceCameraImage extends StatefulWidget {
  const FaceCameraImage({Key? key}) : super(key: key);

  @override
  _FaceCameraTest createState() => _FaceCameraTest();
}

class _FaceCameraTest extends State<FaceCameraImage> {
  File? _capturedImage;
  var imgPath;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Face Image'),
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
                    ElevatedButton(
                        onPressed: () => setState(() => _capturedImage = null),
                        child: const Text(
                          'Capture Again',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),
                           ElevatedButton(
                        onPressed: () {
                           Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Registration(),
                          ));
                        },
                        child: const Text(
                          'Next',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 14,),
                        ))
                        
                  ],
                ),
              );
              
            }
            return SmartFaceCamera(
                autoCapture: true,
                defaultCameraLens: CameraLens.front,
                onCapture: (File? image) {
                 
                  setState(() => _capturedImage = image);
                  imgPath= image!.path;
                  print(imgPath);
                   Fluttertoast.showToast(
                      msg: imgPath,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,  
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                 
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
                
          }
          )
          ),
    );
  }

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
      );
}