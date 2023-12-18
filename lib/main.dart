import 'package:face_camera/face_camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/controller/firebaseApi_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //firebase option FlutterApp (gmail:hekimta@gmail.com)
  // const firebaseOptions = FirebaseOptions(
  //   appId: '1:227756988291:android:1d5994daf1ad04216988b6',
  //   apiKey: 'AIzaSyBpEjaXOCmL44SqegshN1pyiDXV6Tfyanw',
  //   projectId: 'flutterapp-c26b5',
  //   messagingSenderId: '227756988291',
  //   authDomain: 'flutterapp-c26b5.firebaseapp.com',
  // );

   //firebase option FlutterApp (gmail:hekimta@gmail.com)
  // const firebaseOptions = FirebaseOptions(
  //   appId: '1:227756988291:android:1d5994daf1ad04216988b6',
  //   apiKey: 'AIzaSyBpEjaXOCmL44SqegshN1pyiDXV6Tfyanw',
  //   projectId: 'flutterapp-c26b5',
  //   messagingSenderId: '227756988291',
  //   authDomain: 'flutterapp-c26b5.firebaseapp.com',
  // );

  //firebase option smart-parking (gmail:hekimta@gmail.com)
  const firebaseOptions = FirebaseOptions(
    appId: '1:601251091983:android:a7fd23a34760410193f57a',
    apiKey: 'AIzaSyAZ1gYbNl6qwQHpAEV08ZvJakjXnonsO5o',
    projectId: 'smart-parking-5fd71',
    messagingSenderId: '601251091983',
    authDomain: 'smart-parking-5fd71.firebaseapp.com',
  );

  await Firebase.initializeApp(options: firebaseOptions);

  await Firebase.initializeApp();
  FirebaseApi().initNoti();

  FaceCamera.initialize();
  // CheckLogin().checkLogin();

  runApp(const GetMaterialApp(debugShowCheckedModeBanner: false, home: CheckLogin()));
}
class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});
  @override
  State<CheckLogin> createState() => _CheckLogin();
}
class _CheckLogin extends State<CheckLogin> {
   @override
  void initState() {
    super.initState();
    checkLogin();
  }
   Future<void> checkLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var loginSession = prefs.getString("loginSession");
    // print("loginsession : $loginSession");
      if(loginSession == "true"){
         Get.to( HomeNavBar());
      }else{
        Get.to(const LoginWithPhone());
      }

    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginWithPhone(),
    );
  }
}

