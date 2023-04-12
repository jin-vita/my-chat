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
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.circle,
                      color: chatModel.unchecked == 0 ? Colors.transparent : Colors.deepOrange,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    child: Icon(
                      Icons.circle,
                      color: chatModel.unchecked < 10 ? Colors.transparent : Colors.deepOrange,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    child: Icon(
                      Icons.circle,
                      color: chatModel.unchecked < 100 ? Colors.transparent : Colors.deepOrange,
                    ),
                  ),
                  Positioned(
                    right: 12,
                    child: Icon(
                      Icons.circle,
                      color: chatModel.unchecked < 300 ? Colors.transparent : Colors.deepOrange,
                    ),
                  ),
                  Positioned(
                    right: 16,
                    child: Icon(
                      Icons.circle,
                      color: chatModel.unchecked < 300 ? Colors.transparent : Colors.deepOrange,
                    ),
                  ),
                  Positioned(
                    right: chatModel.unchecked < 10
                        ? 8
                        : chatModel.unchecked < 100
                            ? 6.5
                            : 4.2,
                    bottom: 3,
                    child: Text(
                      '${chatModel.unchecked == 0 ? '' : chatModel.unchecked < 300 ? chatModel.unchecked : '300+'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ]),
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
