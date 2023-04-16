import 'package:my_chat/model/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

late ChatModel myModel;

late SharedPreferences pref;
late IO.Socket socket;

List<ChatModel> chatModels = [
  ChatModel(
    id: 'aa',
    name: 'Jin',
    icon: 'person.svg',
    currentMessage: 'Hi you',
    time: '4:02',
    isGroup: false,
    unchecked: 4,
  ),
  ChatModel(
    id: 'bb',
    name: 'Vita',
    icon: 'person.svg',
    currentMessage: 'What are you doing?',
    time: '16:48',
    isGroup: false,
    unchecked: 2,
  ),
  ChatModel(
    id: 'cc',
    name: 'Yun',
    icon: 'person.svg',
    currentMessage: 'How?',
    time: '10:17',
    isGroup: false,
  ),
  ChatModel(
    id: 'dd',
    name: 'Chang',
    icon: 'person.svg',
    currentMessage: 'What a good weather!',
    time: '10:17',
    isGroup: false,
    unchecked: 1,
  ),
];

List<ChatModel> chats = [
  ChatModel(
    id: 'aa',
    name: 'Jin',
    icon: 'person.svg',
    currentMessage: 'Hi you',
    time: '4:02',
    isGroup: false,
  ),
  ChatModel(
    id: 'bb',
    name: 'Vita',
    icon: 'person.svg',
    currentMessage: 'What are you doing?',
    time: '16:48',
    isGroup: false,
  ),
  ChatModel(
    id: 'cc',
    name: 'PANG ',
    icon: 'groups.svg',
    currentMessage: 'This is our project.',
    time: '13:26',
    isGroup: true,
  ),
  ChatModel(
    id: 'dd',
    name: 'Chang',
    icon: 'person.svg',
    currentMessage: 'What a good weather!',
    time: '10:17',
    isGroup: false,
  ),
  ChatModel(
    id: 'ee',
    name: 'Friends',
    icon: 'groups.svg',
    currentMessage: 'Hi everyone!',
    time: '07:33',
    isGroup: true,
  ),
];
