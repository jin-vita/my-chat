import 'package:flutter/material.dart';
import 'package:my_chat/model/chat_model.dart';
import 'package:my_chat/screen/select_screen.dart';
import 'package:my_chat/ui/custom_card.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
      isGroup: false,
      icon: 'person.svg',
      name: 'Jin',
      time: '4:02',
      currentMessage: 'Hi you',
    ),
    ChatModel(
      isGroup: false,
      icon: 'person.svg',
      name: 'Vita',
      time: '16:48',
      currentMessage: 'What are you doing?',
    ),
    ChatModel(
      isGroup: true,
      icon: 'groups.svg',
      name: 'PANG ',
      time: '13:26',
      currentMessage: 'This is our project.',
    ),
    ChatModel(
      isGroup: false,
      icon: 'person.svg',
      name: 'Chang',
      time: '10:17',
      currentMessage: 'What a good weather!',
    ),
    ChatModel(
      isGroup: true,
      icon: 'groups.svg',
      name: 'Friends',
      time: '07:33',
      currentMessage: 'Hi everyone!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => const SelectScreen(),
          ),
        ),
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: chats[index],
        ),
      ),
    );
  }
}
