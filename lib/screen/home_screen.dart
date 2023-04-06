import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat/page/camera_page.dart';
import 'package:my_chat/page/chat_page.dart';

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
        title: const Text('My Chat'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton(onSelected: (value) {
            log('PopupMenuItem : $value');
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
                value: 'whatsapp web',
                child: Text('Whatsapp Web'),
              ),
              const PopupMenuItem(
                value: 'starred messages',
                child: Text('Starred Messages'),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
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
