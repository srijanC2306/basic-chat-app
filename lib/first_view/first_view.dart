import 'package:chat_app/services/push_notification_service.dart';
import 'package:flutter/material.dart';

import 'first_view_manager.dart';

class FirstView extends StatefulWidget with FirstViewManager {

  FirstView({super.key});

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  final PushNotificationService _pushNotificationService = PushNotificationService();

  @override
  void initState() {
    // TODO: implement initState
    _pushNotificationService.initialize(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: widget.nameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () => widget.navigateToChatView(context),
                child: const Text(
                  "Let's Chat",
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}