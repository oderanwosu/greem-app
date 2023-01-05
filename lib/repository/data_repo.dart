import 'dart:convert';

import 'package:greem/models/conversations.dart';
import 'package:greem/utils/api.dart';

import '../models/message.dart';
import '../models/token.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserDataRepository extends APIService {
  final String _baseURL = 'http://localhost:3000';

  UserDataRepository({super.tokens, required super.ref});

  Future<AppUser> getUser({String? id}) async {
    Uri uri = id != null
        ? Uri.parse('$_baseURL/users?id=$id')
        : Uri.parse('$_baseURL/users');

    try {
      http.Response response = await get(uri: uri, requireToken: true);

      Object jsonData = jsonDecode(response.body);

      return AppUser.fromJson(jsonData);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Conversation?>> get conversations async {
    Uri uri = Uri.parse('$_baseURL/conversations');

    try {
      http.Response response = await get(uri: uri, requireToken: true);

      var jsonData = jsonDecode(response.body);
      print(jsonData);
      List<Conversation?> conversations = [];

      jsonData['conversations'].forEach((conversationJson) {
        Conversation conversation = Conversation.fromJson(conversationJson);
        List<Message?> messages = [];
        for (var messageJson in conversationJson['messages']) {
          messages.add(Message.fromJson(messageJson));
        }

        conversation.messages = messages;
        conversations.add(conversation);
      });

      return conversations;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addFriend(String greemCode) async {
    Uri uri = Uri.parse('$_baseURL/friends/send');

    try {
      http.Response response =
          await post(uri: uri, requireToken: true, body: {"greem": greemCode});
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AppUser?>> getFriends() async {
    Uri uri = Uri.parse('$_baseURL/friends/');

    try {
      http.Response response = await get(uri: uri, requireToken: true);

      dynamic jsonData = jsonDecode(response.body);

      List<AppUser?> friends = [];
      jsonData['friends'].forEach((friend) {
        var user = AppUser.fromJson(friend);
        friends.add(user);
      });

      return friends;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AppUser?>> getFriendRequests() async {
    Uri uri = Uri.parse('$_baseURL/friends/request');
    try {
      http.Response response = await get(uri: uri, requireToken: true);
      List<AppUser?> friends = [];
      List friendRequests = jsonDecode(response.body)["friendRequests"];

      for (var friend in friendRequests) {
        AppUser user = AppUser.fromJson(friend);
        friends.add(user);
      }
      return friends;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> acceptFriendRequest(String id) async {
    try {
      Uri uri = Uri.parse('$_baseURL/friends/accept');
      http.Response response =
          await post(uri: uri, body: {"id": id}, requireToken: true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> denyFriendRequest(String id) async {
    try {
      Uri uri = Uri.parse('$_baseURL/friends/deny');
      http.Response response =
          await delete(uri: uri, body: {"id": id}, requireToken: true);
    } catch (e) {
      rethrow;
    }
  }
}
