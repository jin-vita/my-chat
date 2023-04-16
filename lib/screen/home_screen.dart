import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_chat/dummy/chats_dummy.dart';
import 'package:my_chat/main.dart';
import 'package:my_chat/model/message_model.dart';
import 'package:my_chat/page/camera_page.dart';
import 'package:my_chat/page/chat_page.dart';
import 'package:my_chat/screen/login_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1,
    );
    connect();
  }

  connect() {
    socket = IO.io(
      // 'http://192.168.43.234:5000',
      'http://10.1.19.2:5000',
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build(),
    );
    socket.connect();
    socket.emit('sign-in', myModel.id);
    socket.onConnect(
      (data) {
        logger.d('socket connected ${myModel.id}');
      },
    );
    socket.on(
      'message',
      (dynamic message) {
        // message: {from: dd, to: cc, message: aaa}
        // 접속자가 to 일 때 메시지 받음.
        logger.d('message: $message');
        addMessage(message: message);
      },
    );
    socket.on(
      'isRead',
      (dynamic message) {
        // message: {from: dd, to: cc, message: aaa}
        // 접속자가 to 일 때 메시지 받음.
        logger.d('check: $message');
        readMessage(message: message);
      },
    );
  }

  addMessage({
    required dynamic message,
  }) {
    List<String> messageList = pref.getStringList('${message['to']}_${message['from']}') ?? [];
    messageList.insert(0, jsonEncode(message));
    if (messageList.length > 100) messageList.removeLast();
    pref.setStringList(
      '${message['to']}_${message['from']}',
      messageList,
    );
  }

  readMessage({
    required dynamic message,
  }) {
    List<String> messageList = pref.getStringList('${myModel.id}_${message['from']}') ?? [];
    List<String> changedList = [];
    for (var item in messageList) {
      MessageModel messageModel = jsonDecode(item);
      if (messageModel.time == jsonDecode(message).time) {
        messageModel.isRead = message['isRead'];
      }
      changedList.add(jsonEncode(messageModel.toJson()));
    }

    pref.setStringList(
      '${myModel.id}_${message['from']}',
      changedList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: Text('${myModel.name}님 반가워요!'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton(onSelected: (value) {
            logger.i('PopupMenuItem : $value');
            switch (value) {
              case 'new group':
              case 'new broadcast':
              case 'settings':
                break;
              case 'clear pref':
                pref.clear();
                break;
              case 'logout':
                myModel.unchecked = Random().nextInt(400);
                chatModels.add(myModel);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const LoginScreen(),
                  ),
                );
                break;
            }
          }, itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'new group',
                child: Text('New Group'),
              ),
              const PopupMenuItem(
                value: 'new broadcast',
                child: Text('New BroadCast'),
              ),
              const PopupMenuItem(
                value: 'clear pref',
                child: Text('Clear Pref'),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('LogOut'),
              ),
            ];
          }),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _controller,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: 'CHATS',
            ),
            Tab(
              text: 'STATUS',
            ),
            Tab(
              text: 'CALLS',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          CameraPage(),
          ChatPage(),
          Center(child: Text('status')),
          Center(child: Text('calls')),
        ],
      ),
    );
  }
}
