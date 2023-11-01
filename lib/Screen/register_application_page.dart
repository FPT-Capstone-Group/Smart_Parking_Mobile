// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RegisterApplication extends StatefulWidget {
//   const RegisterApplication({super.key});

//   @override
//   State<RegisterApplication> createState() => _RegisterApplication();
// }

// class _RegisterApplication extends State<RegisterApplication> {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   late Future<String?> token;

//  @override
//   void initState() {
//     super.initState();
//     token = _prefs.then((SharedPreferences prefs) {
//       print(prefs.getString('token'));
//       return prefs.getString('token');
      
//     });
//   }

  //   }
  // }

  // Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class RegisterApplication extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> { 

  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) { 
    return  Scaffold(
          appBar: AppBar(
            title: Text("Image Picker from Gallery"),
            backgroundColor: Colors.redAccent
          ),
          body: Container(
            padding: EdgeInsets.only(top:20, left:20, right:20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [

                 ElevatedButton(
                  onPressed: () async {
                      image = await picker.pickImage(source: ImageSource.gallery); 
                      setState(() {
                        //update UI
                      });
                  }, 
                  child: Text("Pick Image")
                ),
 
                image == null?Container():
                Image.file(File(image!.path))
                
            ],)
          )
       );
  }
}