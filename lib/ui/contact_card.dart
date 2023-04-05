import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_chat/model/chat_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundColor: Colors.blueGrey.shade200,
            child: SvgPicture.asset(
              'assets/icons/${contact.icon}',
              height: 30,
              width: 30,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          Visibility(
            visible: contact.selected,
            child: const Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.check,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      title: Text(
        contact.name,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contact.status,
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
