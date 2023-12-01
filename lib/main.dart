
import 'package:face_camera/face_camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/Screen/profile.dart';
import 'package:parking_auto/Screen/register_account.dart';
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:parking_auto/Screen/setting.dart';
import 'package:parking_auto/Screen/user_profile.dart';
// import 'package:parking_auto/Screen/my_profile.dart';
// import 'package:parking_auto/Screen/register_account.dart';
// import 'package:parking_auto/Screen/registration_hitory.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

   // firebase option parkingauto (gmail:hekimta@gmail.com)
  const firebaseOptions = FirebaseOptions(
    appId: '1:551718773591:android:24033e9e023cc944bf9412',
    apiKey: 'AIzaSyDNW6v89hiVt603ROCUeD6GUybhMBX2yjU',
    projectId: 'parkingauto-78411',
    messagingSenderId: '551718773591',
    authDomain: 'parkingauto-78411.firebaseapp.com',
  );

  //firebase option smart-parking (gmail:hekimta@gmail.com)
  // const firebaseOptions = FirebaseOptions(
  //   appId: '1:601251091983:android:a7fd23a34760410193f57a',
  //   apiKey: 'AIzaSyAZ1gYbNl6qwQHpAEV08ZvJakjXnonsO5o',
  //   projectId: 'smart-parking-5fd71',
  //   messagingSenderId: '601251091983',
  //   authDomain: 'smart-parking-5fd71.firebaseapp.com',
  // );

  // firebase option FlutterApp (gmail:hekimta@gmail.com)
  // const firebaseOptions = FirebaseOptions(
  //   appId: '1:227756988291:android:1d5994daf1ad04216988b6',
  //   apiKey: 'AIzaSyBpEjaXOCmL44SqegshN1pyiDXV6Tfyanw',
  //   projectId: 'flutterapp-c26b5',
  //   messagingSenderId: '227756988291',
  //   authDomain: 'flutterapp-c26b5.firebaseapp.com',
  // );

  await Firebase.initializeApp(
    options: firebaseOptions
  );
  // await Firebase.initializeApp();
  FaceCamera.initialize();
  runApp(GetMaterialApp(    debugShowCheckedModeBanner: false,
    home: MyApp()));
  //runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    //home: FaceCameraImageOwner(),
       home:LoginWithPhone(),
    );
  }
}
class MainScreen extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginWithPhone.routeNamed,
      getPages: [
        // GetPage(
        //   name: MyproFile.routeNamed,
        //   page: () => MyproFile(),
        // ),
        GetPage(
          name: RegisterAccountScreen.routeNamed,
          page: () => RegisterAccountScreen(),
        ),
        GetPage(
          name: ProFile.routeNamed,
          page: () => ProFile(),
        ),
        GetPage(
          name: HomePage.routeNamed,
          page: () => HomePage(),
        ),
        GetPage(
          name: RegistrationHistory.routeNamed,
          page: () => RegistrationHistory(),
        ),
        GetPage(
          name: SettingsPage.routeNamed,
          page: () => SettingsPage(),
        ),
         GetPage(
          name: GetUPage.routeNamed,
          page: () => GetUPage(),
        ),
      ],
    );
  }
}