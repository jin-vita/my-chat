import 'package:flutter/material.dart';
import 'package:my_chat/dummy/contacts_dummy.dart';
import 'package:my_chat/ui/avtar_card.dart';
import 'package:my_chat/ui/contact_card.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
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
    return Stack(
      children: [
        ListView.builder(
          itemCount: contacts.length + 1,
          itemBuilder: (context, index) {
            return index == 0
                ? groups.isEmpty
                    ? const SizedBox()
                    : const SizedBox(height: 80)
                : InkWell(
                    onTap: () {
                      setState(() {
                        contacts[index - 1].selected
                            ? groups.remove(contacts[index - 1])
                            : groups.add(contacts[index - 1]);
                        contacts[index - 1].selected = !contacts[index - 1].selected;
                      });
                    },
                    child: ContactCard(
                      contact: contacts[index - 1],
                    ),
                  );
          },
        ),
        groups.isNotEmpty
            ? Column(
                children: [
                  Container(
                    height: 80,
                    color: Colors.white,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        return contacts[index].selected
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    groups.remove(contacts[index]);
                                    contacts[index].selected = false;
                                  });
                                },
                                child: AvtarCard(
                                  contact: contacts[index],
                                ),
                              )
                            : const SizedBox();
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  )
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
