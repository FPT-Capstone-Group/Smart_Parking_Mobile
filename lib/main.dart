import 'package:face_camera/face_camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/login_with_phone.dart';
import 'package:parking_auto/Screen/register.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const firebaseOptions = FirebaseOptions(
  appId: '1:551718773591:android:24033e9e023cc944bf9412',
  apiKey: 'AIzaSyDNW6v89hiVt603ROCUeD6GUybhMBX2yjU',
  projectId: 'parkingauto-78411',
  messagingSenderId: '551718773591',
  authDomain: 'parkingauto-78411.firebaseapp.com',
);
  await Firebase.initializeApp(
    options: firebaseOptions
  );
  // await Firebase.initializeApp();
  FaceCamera.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterUser(),
      //home: HomePage(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select Option"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWithPhone()));
                },
                child: Text("Login with google")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWithPhone()));
                },
                child: Text("Login with facebook")),

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWithPhone()));
                },
                child: Text("Login with Phone")),

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWithPhone()));
                },
                child: Text("Login with Twitter"))
          ],
        ),
      ),
    );
  }
}