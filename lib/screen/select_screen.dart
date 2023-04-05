import 'package:flutter/material.dart';
import 'package:my_chat/dummy/contacts_dummy.dart';
import 'package:my_chat/screen/group_screen.dart';
import 'package:my_chat/ui/button_card.dart';
import 'package:my_chat/ui/contact_card.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({Key? key}) : super(key: key);

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
        children: [
          const Text(
            'Select contact',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${contacts.length} contacts',
            style: const TextStyle(
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
    return WillPopScope(
      onWillPop: () {
        for (var item in contacts) {
          item.selected = false;
        }

        groups.clear();
        return Future(() => true);
      },
      child: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {
          return index == 0
              ? InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => const GroupScreen(),
                    ),
                  ),
                  child: const ButtonCard(
                    name: 'New Group',
                    icon: Icons.group,
                  ),
                )
              : index == 1
                  ? const ButtonCard(
                      name: 'New Contact',
                      icon: Icons.person_add,
                    )
                  : ContactCard(
                      contact: contacts[index - 2],
                    );
        },
      ),
    );
  }
}
