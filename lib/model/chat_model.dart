class ChatModel {
  String name;
  String icon;
  String status;
  String? currentMessage;
  String? time;
  bool? isGroup;
  bool selected;
  String id;
  int unchecked;

  ChatModel({
    required this.id,
    required this.name,
    this.icon = 'person.svg',
    this.status = 'developer',
    this.currentMessage,
    this.time,
    this.isGroup,
    this.selected = false,
    this.unchecked = 0,
  });
}
