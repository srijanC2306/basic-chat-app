import 'package:chat_app/chat_view/chat_view.dart';
import 'package:flutter/cupertino.dart';

mixin class FirstViewManager{
  final TextEditingController nameController = TextEditingController();

  navigateToChatView(BuildContext context){
      Navigator.push(context , CupertinoPageRoute(builder: (_) => ChatView(name: nameController.text)));
  }
}