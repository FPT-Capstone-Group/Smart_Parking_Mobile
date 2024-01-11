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
      // final _localNoti = FlutterLocalNotificationsPlugin();

      FirebaseMessaging.onBackgroundMessage(handleBackgroudMessaging);
      // final _androidChannel = const AndroidNotificationChannel(
      //   'high_importan',
      //   'high importance noti',
      //   description: 'This is channel noti',
      //   importance: Importance.defaultImportance,
      // );
      // FirebaseMessaging.onMessage.listen((message) {
      //   final notification = message.notification;
      //   if(notification ==  null){
      //     return;
      //   }
      //   _localNoti.show(notification.hashCode, notification.title, notification.body, NotificationDetails(android: AndroidNotificationDetails(_androidChannel.id, _androidChannel.name,channelDescription: _androidChannel.description,
      //   icon: '@drawble/ic launcher')),
      //   payload: jsonEncode(message.toMap()),
      //   );
      //  });
    }

    Future<void> handleBackgroudMessaging(RemoteMessage message) async{
      // print("title: ${message.notification?.title}");
      // print("body: ${message.notification?.title}");
      // print("payload: ${message.data}");
    }
}