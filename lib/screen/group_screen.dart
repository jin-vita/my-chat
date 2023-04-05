import 'package:flutter/material.dart';
import 'package:my_chat/dummy/contacts_dummy.dart';
import 'package:my_chat/model/chat_model.dart';
import 'package:my_chat/ui/contact_card.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'New Group',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Add participants',
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            size: 26,
          ),
        ),
      ],
    );
  }

  _body() {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          setState(() {
            contacts[index].selected ? groups.remove(contacts[index]) : groups.add(contacts[index]);
            contacts[index].selected = !contacts[index].selected;
          });
        },
        child: ContactCard(
          contact: contacts[index],
        ),
      ),
    );
  }
}
