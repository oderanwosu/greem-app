import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Tokens {
  String? token;
  String? refreshToken;

  Tokens({this.token, this.refreshToken});

  factory Tokens.fromJson(json) {
    return Tokens(
        token: json['accessToken'], refreshToken: json['refreshToken']);
  }

  localSave() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('tokens',
        jsonEncode({"accessToken": token, "refreshToken": refreshToken}));
  }

  deleteLocalTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('tokens');
    token = null;
    refreshToken = null;
  }

  Future<Tokens?> getlocalToken() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var json = prefs.getString('tokens');

      if (json == null) return null;
      var tokens = Tokens.fromJson(jsonDecode(json));

      return tokens;
    } catch (e) {
      rethrow;
    }
  }

  Stream<Tokens?> getlocalTokenStream() async* {
    Tokens? tokens = await getlocalToken();

    yield tokens;
  }
}
