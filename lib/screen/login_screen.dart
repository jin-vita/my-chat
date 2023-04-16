import 'package:flutter/material.dart';
import 'package:my_chat/dummy/chats_dummy.dart';
import 'package:my_chat/screen/home_screen.dart';
import 'package:my_chat/ui/button_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LOG - IN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            myModel = chatModels[index];
            myModel.unchecked = 0;
            chatModels.removeAt(index);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (builder) => const HomeScreen(),
              ),
            );
          },
          child: ButtonCard(
            name: chatModels[index].name,
            icon: Icons.person,
          ),
        ),
      ),
    );
  }
}
