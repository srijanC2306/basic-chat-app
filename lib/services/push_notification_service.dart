import 'package:chat_app/main.dart';
import 'package:chat_app/scecond_screen.dart';
import 'package:chat_app/widget/notification_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  late FirebaseMessaging _firebaseMessaging;

  PushNotificationService() {
    _firebaseMessaging = FirebaseMessaging.instance;
  }

  void initialize(BuildContext context) {
    _handleForegroundMessages(context);
    _handleBackgroundMessages();
    _handleTerminatedMessages(context);
  }

  void _handleForegroundMessages(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if(kDebugMode){
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }


      if (message.notification != null) {
        if(kDebugMode) print('Message also contained a notification: ${message.notification}');
        NotificationDialog.showNotificationDialog(context, message.notification);
      }
    });
  }

  void _handleBackgroundMessages() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _handleTerminatedMessages(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if(kDebugMode)  print('A new onMessageOpenedApp event was published!');
      _navigateToTargetPage( message.data);
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        if(kDebugMode)   print('Initial message received');
        _navigateToTargetPage( message.data);
      }
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if(kDebugMode) print('Handling a background message: ${message.messageId}');
    // Handle background message
  }


  void _navigateToTargetPage(Map<String, dynamic> data) {
    globalNavKey.currentState!.pushNamed( SecondScreen.secondScreenRoute);
  }
}
