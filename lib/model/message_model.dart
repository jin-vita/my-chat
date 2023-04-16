class MessageModel {
  String from;
  String to;
  String message;
  String time;
  String network;

  MessageModel({
    required this.from,
    required this.to,
    required this.message,
    required this.time,
    required this.network,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : from = json['from'],
        to = json['to'],
        message = json['message'],
        time = json['time'],
        network = json['network'];

  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
        'message': message,
        'time': time,
        'network': network,
      };
}
