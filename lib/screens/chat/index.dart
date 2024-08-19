import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shopipi_mobile_v2/webSocketService.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        toolbarHeight: 40,
      ),
      body: GFButton(
        onPressed: () {
          WebSocketService().sendMessage('/app/chat.send', {
            "message": "test from flutter",
            "senderId": "661e677a4326be0575450488",
            "receiverId": "6680dfff69dddc1a78bfaf0f"
          });
        },
        text: 'send message',
        type: GFButtonType.transparent,
        size: GFSize.SMALL,
        shape: GFButtonShape.square,
        fullWidthButton: false,
      ),
    );
  }
}
