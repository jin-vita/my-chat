import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_chat/model/chat_model.dart';
import 'package:my_chat/screen/individual_screen.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.chatModel,
  }) : super(key: key);
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IndividualScreen(
                  chatModel: chatModel,
                ),
              ),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                'assets/icons/${chatModel.icon}',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                height: 40,
                width: 40,
              ),
            ),
            title: Text(
              chatModel.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.done_all,
                  color: Colors.black,
                ),
                const SizedBox(width: 5),
                Text(
                  chatModel.currentMessage,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            right: 20,
            left: 80,
          ),
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
