import 'package:flutter/material.dart';
import 'package:my_chat/dummy/chats_dummy.dart';
import 'package:my_chat/screen/select_screen.dart';
import 'package:my_chat/ui/custom_card.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF128C7E),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => const SelectScreen(),
          ),
        ),
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chatModels.length + 1,
        itemBuilder: (context, index) => index == 0
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    '나와의 채팅',
                    style: TextStyle(
                      color: Color(0xFF075E54),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  CustomCard(chatModel: myModel),
                  const Text(
                    '채팅 리스트',
                    style: TextStyle(
                      color: Color(0xFF075E54),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              )
            : CustomCard(
                chatModel: chatModels[index - 1],
              ),
      ),
    );
  }
}
