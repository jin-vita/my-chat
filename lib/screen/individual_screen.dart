import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_chat/model/chat_model.dart';
import 'package:my_chat/ui/message_card.dart';
import 'package:my_chat/ui/reply_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({
    Key? key,
    required this.chatModel,
  }) : super(key: key);

  final ChatModel chatModel;

  @override
  State<IndividualScreen> createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late final IO.Socket socket;
  bool isSendButton = false;

  @override
  void initState() {
    super.initState();
    connect();
  }

  connect() {
    socket = IO.io(
        'http://10.1.19.2:5000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.emit('/test', 'hello world');
    socket.onConnect((data) => log('socket connected'));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/chat_back.png',
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _appBar(context),
        body: _body(context),
      ),
    ]);
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF075E54),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blueGrey,
            child: SvgPicture.asset(
              'assets/icons/${widget.chatModel.icon}',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              height: 35,
              width: 35,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chatModel.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'last seen today at 12:05',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.videocam,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.call,
          ),
        ),
      ],
    );
  }

  SizedBox _body(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: WillPopScope(
        onWillPop: () => _backAction(context),
        child: Stack(
          children: [
            ListView(
              children: const [
                MessageCard(
                  time: '08:20',
                  message: '좋은 아침!',
                ),
                ReplyCard(
                  time: '09:47',
                  message: '응ㅋㅋ 그래',
                ),
                MessageCard(
                  time: '09:51',
                  message: '오늘 기분은 어때? 밥은 먹었어? 뭐 먹었어?',
                ),
                ReplyCard(
                  time: '12:08',
                  message: '음.. 왜?',
                ),
                MessageCard(
                  time: '12:11',
                  message:
                      '그냥 너가 잠을 푹 잘 잤는지,\n밥을 잘 먹었는지, 기분은 좋은지,\n오늘도 그 전에 연락준 3일 전처럼 크게 아픈 곳 없이 건강한지 궁금해서 ~',
                  isRead: false,
                ),
              ],
            ),
            _typingBar(context),
          ],
        ),
      ),
    );
  }

  Future<bool> _backAction(BuildContext context) {
    Navigator.pop(context);
    return Future(() => false);
  }

  _typingBar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 55,
            child: Card(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextFormField(
                onChanged: (value) => setState(() {
                  isSendButton = value.isNotEmpty;
                }),
                controller: _controller,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a message',
                  prefixIcon: IconButton(
                      icon: const Icon(Icons.emoji_emotions),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          barrierColor: Colors.transparent,
                          builder: (builder) => _emojiSelect(),
                        );
                      }),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (builder) => _bottomSheet(),
                          );
                        },
                        icon: const Icon(Icons.attach_file),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: const Color(0xFF128C7E),
            radius: 25,
            child: isSendButton
                ? IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                  )
                : IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: () {},
                  ),
          ),
        ],
      ),
    );
  }

  _bottomSheet() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      height: 280,
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconCreation(
                  text: 'Document',
                  icon: Icons.insert_drive_file,
                ),
                iconCreation(
                  text: 'Camera',
                  icon: Icons.camera_alt,
                  color: Colors.pink,
                ),
                iconCreation(
                  text: 'Gallery',
                  icon: Icons.insert_photo,
                  color: Colors.purple,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconCreation(
                  text: 'Audio',
                  icon: Icons.headset,
                  color: Colors.orange,
                ),
                iconCreation(
                  text: 'location',
                  icon: Icons.location_pin,
                  color: Colors.lightGreen,
                ),
                iconCreation(
                  text: 'Contact',
                  icon: Icons.person,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  iconCreation({
    required String text,
    required IconData icon,
    Color color = Colors.teal,
  }) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  _emojiSelect() {
    return SizedBox(
      height: 280,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: EmojiPicker(
          onEmojiSelected: (category, emoji) => setState(
            () {
              _controller.text += emoji.emoji;
            },
          ),
        ),
      ),
    );
  }
}
