import 'package:my_chat/model/chat_model.dart';

List<ChatModel> chats = [
  ChatModel(
    name: 'Jin',
    icon: 'person.svg',
    currentMessage: 'Hi you',
    time: '4:02',
    isGroup: false,
  ),
  ChatModel(
    name: 'Vita',
    icon: 'person.svg',
    currentMessage: 'What are you doing?',
    time: '16:48',
    isGroup: false,
  ),
  ChatModel(
    name: 'PANG ',
    icon: 'groups.svg',
    currentMessage: 'This is our project.',
    time: '13:26',
    isGroup: true,
  ),
  ChatModel(
    name: 'Chang',
    icon: 'person.svg',
    currentMessage: 'What a good weather!',
    time: '10:17',
    isGroup: false,
  ),
  ChatModel(
    name: 'Friends',
    icon: 'groups.svg',
    currentMessage: 'Hi everyone!',
    time: '07:33',
    isGroup: true,
  ),
];
