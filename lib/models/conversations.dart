import 'package:greem/providers/data_provider.dart';
import 'package:greem/repository/data_repo.dart';
import 'package:riverpod/riverpod.dart';

import 'message.dart';
import 'user.dart';

class Conversation {
  String id;
  String? adminID;
  bool private;
  List<String> memberIDs;
  List<Object> messageObects;
  int createdAt;

  // Future<List<AppUser>> getMembers(Ref ref) async {
  //   List<AppUser> members = [];

  //   for (var memberId in memberIDs) {
  //     AppUser? user = await ref.read(dataRepositoryProvider).getUser(memberId);
  //     members.add(user!);
  //   }

  //   return members;
  // }

  Conversation(
      {required this.id,
      this.adminID,
      required this.private,
      required this.memberIDs,
      required this.messageObects,
      required this.createdAt});

  factory Conversation.fromJson(json) {
    return Conversation(
        id: json['id'],
        private: json['private'],
        memberIDs: json['members'],
        messageObects: json['messages'],
        createdAt: json['createdAt'],
        adminID: json['adminID']);
  }
}
