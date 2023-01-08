import 'package:greem/providers/data_provider.dart';
import 'package:greem/repository/data_repo.dart';
import 'package:riverpod/riverpod.dart';

import 'message.dart';
import 'user.dart';

class Conversation {
  String? userID;
  String id;
  String? name;
  String? adminID;
  bool private;
  List<dynamic> memberIDs;
  List<Message?> messages = [];
  int createdAt;

  // Future<List<AppUser>> getMembers(Ref ref) async {
  //   List<AppUser> members = [];

  //   for (var memberId in memberIDs) {
  //     AppUser? user = await ref.read(dataRepositoryProvider).getUser(memberId);
  //     members.add(user!);
  //   }

  //   return members;
  // }

  Message? get latestMessage {
    return messages.isEmpty ? null : messages[messages.length - 1];
  }

  Conversation(
      {this.userID,
      required this.id,
      this.adminID,
      this.name,
      required this.private,
      required this.memberIDs,
      required this.createdAt});

  factory Conversation.fromJson(json) {
    return Conversation(
        userID: json['user_id'],
        id: json['id'],
        name: json['name'],
        private: json['private'],
        memberIDs: json['members'],
        createdAt: json['createdAt'],
        adminID: json['admin']);
  }
}
