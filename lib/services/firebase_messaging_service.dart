import 'package:chat_app/chat_view/chat_view.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/scecond_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  void initialize() {
    _fcm.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }


  // void _showNotificationDialog(RemoteNotification? remoteNotification){
  //   if(remoteNotification !=null){
  //     showGeneralDialog(context: context, pageBuilder: pageBuilder)
  //   }

  void initPushNotification() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
     FirebaseMessaging.instance.getInitialMessage().then(handleMessage );
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
   print("Caled Handle Message");
    globalNavKey.currentState?.pushNamed(SecondScreen.secondScreenRoute);
  }

  void getToken() async {
    String? token = await _fcm.getToken();
    if (token != null) {
      print("The token is $token");
      //  await saveTokenToDatabase(token);
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    globalNavKey.currentState?.push(
        MaterialPageRoute(builder: (_) => const SecondScreen()));
    print('Handling a background message: ${message.messageId}');
    print('Handling a background message body : ${message.notification?.body}');
    print('Handling a background message Payload : ${message.data}');
  }
}


