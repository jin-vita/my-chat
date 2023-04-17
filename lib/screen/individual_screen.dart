import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_chat/dummy/chats_dummy.dart';
import 'package:my_chat/model/chat_model.dart';
import 'package:my_chat/model/message_model.dart';
import 'package:my_chat/ui/message_card.dart';
import 'package:my_chat/ui/reply_card.dart';

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
  final ScrollController _sController = ScrollController();
  List<String> stringMessages = [];
  List<MessageModel> messages = [];
  bool _isSendButton = false;

  @override
  void initState() {
    super.initState();
    setMessageList();
  }

  setMessageList() {
    stringMessages = pref.getStringList('${myModel.id}_${widget.chatModel.id}') ?? [];
    setMessageModels();
  }

  sendMessage({
    required String from,
    required String to,
    required String message,
  }) {
    int randomNumber = Random().nextInt(100000);
    String randomString = randomNumber.toString().padLeft(5, '0');
    String time = DateFormat('yyyy년 MM월 dd일|HH:mm|ssSSS').format(DateTime.now()) + randomString;

    final messageForm = {
      'from': from,
      'to': to,
      'message': message,
      'time': time,
      'network': 'PENDING',
      'isRead': false,
    };

    setMessage(message: messageForm);

    Timer(
      const Duration(milliseconds: 500),
      () => checkMessage(message: messageForm),
    );

    if (from != to) {
      Timer(
        const Duration(milliseconds: 2000),
        () => autoReplyMessage(from: from, to: to, message: message),
      );
    }
  }

  autoReplyMessage({
    required String from,
    required String to,
    required String message,
  }) {
    int randomNumber = Random().nextInt(100000);
    String randomString = randomNumber.toString().padLeft(5, '0');
    String time = DateFormat('yyyy년 MM월 dd일|HH:mm|ssSSS').format(DateTime.now()) + randomString;

    final messageForm = {
      'from': to,
      'to': from,
      'message': '$message$message~',
      'time': time,
      'network': 'OK',
      'isRead': true,
    };

    stringMessages.insert(0, jsonEncode(messageForm));
    if (stringMessages.length > 100) stringMessages.removeLast();
    messages.clear();
    List<String> stringMessages2 = [];
    setState(() {
      for (var item in stringMessages) {
        MessageModel message = MessageModel.fromJson(jsonDecode(item));
        message.isRead = true;
        stringMessages2.add(jsonEncode(message.toJson()));
        messages.add(message);
      }
      stringMessages = stringMessages2;
      pref.setStringList(
        '${from}_$to',
        stringMessages,
      );
    });
  }

  setMessage({
    required dynamic message,
  }) {
    stringMessages.insert(0, jsonEncode(message));
    if (stringMessages.length > 100) stringMessages.removeLast();
    pref.setStringList(
      '${message['from']}_${message['to']}',
      stringMessages,
    );
    setState(() {
      setMessageModels();
    });
    scrollToBot();
  }

  setMessageModels() {
    messages.clear();
    for (var item in stringMessages) {
      MessageModel message = MessageModel.fromJson(jsonDecode(item));
      if ((message.from != myModel.id || message.from == message.to) && !message.isRead) {
        message.isRead = true;
      }
      messages.add(message);
    }
  }

  checkMessage({
    required dynamic message,
  }) {
    stringMessages.clear();
    for (var item in messages) {
      if (item.time == message['time']) {
        item.network = 'OK';
      }
      stringMessages.add(jsonEncode(item.toJson()));
    }
    setState(() {
      pref.setStringList(
        '${myModel.id}_${message['to']}',
        stringMessages,
      );
    });
  }

  scrollToBot() {
    _sController.animateTo(
      _sController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/chat_back.png',
        width: MediaQuery.of(context).size.width,
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

  _body(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _backAction(context),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _sController,
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return message.from == myModel.id
                    ? MessageCard(message: message)
                    : ReplyCard(message: message);
              },
            ),
          ),
          _typingBar(context),
        ],
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
                  _isSendButton = value.isNotEmpty;
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
            child: _isSendButton
                ? IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      sendMessage(
                        from: myModel.id,
                        to: widget.chatModel.id,
                        message: _controller.text,
                      );
                      _controller.clear();
                      _isSendButton = false;
                    },
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
