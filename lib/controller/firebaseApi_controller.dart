import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi {
  
    final _firebaseMessagin = FirebaseMessaging.instance;
    Future<void> initNoti() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await _firebaseMessagin.requestPermission();
      final fcmToken = await _firebaseMessagin.getToken();
      if(fcmToken==null){
        fcmToken =="";
      }
      
       prefs.remove('deviceFireBasetoken');
       prefs.setString('deviceFireBasetoken', fcmToken.toString());

      FirebaseMessaging.onBackgroundMessage(handleBackgroudMessaging);
    }

    Future<void> handleBackgroudMessaging(RemoteMessage message) async{
      // print("title: ${message.notification?.title}");
      // print("body: ${message.notification?.title}");
      // print("payload: ${message.data}");
    }
}