import 'package:chat_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationDialog {
  static void showNotificationDialog(
      BuildContext context, RemoteNotification? notification) {
    if (notification != null) {
      showGeneralDialog(
          context: context,
          pageBuilder: (context, _, __) {
            return AlertDialog(
              title: Text(notification.title ?? 'No Title'),
              content: Text(notification.body ?? ''),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      globalNavKey.currentState?.pop();
                    },
                    child: const Text('OK'))
              ],
            );
          });
    }
  }
}
