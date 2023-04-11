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
    List<Shadow> shadows = [];
    for (int i = 1; i < 9; i++) {
      for (int j = 0; j < i; j++) {
        shadows.add(
          Shadow(
            color: Colors.deepOrange,
            blurRadius: i.toDouble(),
          ),
        );
      }
    }

    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => IndividualScreen(
                chatModel: chatModel,
              ),
            ),
          ),
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  chatModel.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${chatModel.time}',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${chatModel.currentMessage}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '6',
                  style: TextStyle(
                    color: Colors.white,
                    shadows: shadows,
                  ),
                ),
              ],
            ),
            // trailing: Text('${chatModel.time}'),
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
