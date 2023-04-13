import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_chat/dummy/chats_dummy.dart';
import 'package:my_chat/main.dart';
import 'package:my_chat/page/camera_page.dart';
import 'package:my_chat/page/chat_page.dart';
import 'package:my_chat/screen/login_screen.dart';

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
