import 'package:greem/models/user.dart';
import 'package:timeago/timeago.dart' as timeago;

class Message {
  int id;
  String senderID;
  String body;
  DateTime sentAt;
  bool? isFromUser = false;
  AppUser? sender;

  Message(
      {
      this.isFromUser,
      this.sender,
      required this.id,
      required this.senderID,
      required this.body,
      required this.sentAt});

  factory Message.fromJson(json) {
    return Message(
      isFromUser: json["fromUser"],
        id: json['id'],
        senderID: json['sender_id'],
        body: json['body'],
        sentAt: DateTime.fromMillisecondsSinceEpoch(json['sentAt']));
  }

  String get timeSentAgo {
    return timeago.format(sentAt);
  }
}
