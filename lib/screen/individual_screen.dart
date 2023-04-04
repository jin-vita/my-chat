import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_chat/model/chat_model.dart';

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({
    Key? key,
    required this.chatModel,
  }) : super(key: key);

  final ChatModel chatModel;

  @override
  State<IndividualScreen> createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> {
  bool _isShow = false;
  final FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _isShow = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.arrow_back),
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
          ],
        ),
      ),
      titleSpacing: 0,
      title: Column(
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
        onWillPop: () => backAction(context),
        child: Stack(
          children: [
            // ListView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  typingBar(context),
                  emojiSelect(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> backAction(BuildContext context) {
    if (_isShow) {
      setState(() {
        _isShow = false;
      });
    } else {
      Navigator.pop(context);
    }
    return Future(() => false);
  }

  Row typingBar(BuildContext context) {
    return Row(
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
              controller: _controller,
              focusNode: _focusNode,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type a message',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.emoji_emotions),
                  onPressed: () => setState(() {
                    _focusNode.unfocus();
                    _focusNode.canRequestFocus = false;
                    _isShow = !_isShow;
                  }),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (builder) => bottomSheet(),
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
          radius: 25,
          child: IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  bottomSheet() {
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

  emojiSelect() {
    return _isShow
        ? SizedBox(
            height: 275,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) => setState(() {
                _controller.text += emoji.emoji;
              }),
            ),
          )
        : const SizedBox();
  }
}
