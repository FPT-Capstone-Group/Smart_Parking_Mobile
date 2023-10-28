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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_widget/image_picker_widget.dart';

class RegisterApplication extends StatelessWidget {
  const RegisterApplication({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: Center(
          child: ImagePickerWidget(
        diameter: 180,
        initialImage:
            "https://strattonapps.com/wp-content/uploads/2020/02/flutter-logo-5086DD11C5-seeklogo.com_.png",
        shape: ImagePickerWidgetShape.circle,
        isEditable: true,
        shouldCrop: true,
        imagePickerOptions: ImagePickerOptions(
          imageQuality: 65
        ),
        onChange: (File file) {
          print("I changed the file to: ${file.path}");
        },
      )
      ),
    );
  }
}
