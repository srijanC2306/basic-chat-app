import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../core/web_socket_manager.dart';
import 'chat_view_manager.dart';

class ChatView extends StatefulWidget {
  final String name;

  const ChatView({super.key, required this.name});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with ChatViewManager {
  @override
  void initState() {
    //Connect to websocket
    WebSocketManager.instance.initializeSocketConnection();

    //Listen chat channel
    listenMessageEvent(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //For pop button
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[Expanded(child: buildMessages()), buildInput()],
        ),
      ),
    );
  }

  Widget buildMessages() {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: setMessageAlignment(messages[index].sender, widget.name),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(messages[index].sender),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(messages[index].msg),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget buildInput() {
    return SafeArea(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: msgController,
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () => sendMessage(widget.name, () {
                setState(() {});
              }),
              child: const Text("Send"),
            ),
          )
        ],
      ),
    );
  }
}
