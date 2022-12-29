import 'dart:convert';

import 'package:greem/models/conversations.dart';
import 'package:greem/utils/api.dart';

import '../models/token.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserDataRepository extends APIService {
  final String _baseURL = 'http://localhost:3000';

  UserDataRepository({super.tokens, required super.ref});

  Future<AppUser?> getUser(String id) async {
    Uri uri = Uri.parse('$_baseURL/$id');
    try {
      http.Response response = await get(uri: uri, requireToken: true);

      if (!(response.statusCode == 200)) {
        throw jsonDecode(response.body)["error_description"];
      }
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

      List<dynamic> jsonData = jsonDecode(response.body);
      List<Conversation?> conversations = [];
      jsonData.forEach((conversation) {
        conversations.add(Conversation.fromJson(jsonData));
      });

      return conversations;
    } catch (e) {
      rethrow;
    }
  }
}
