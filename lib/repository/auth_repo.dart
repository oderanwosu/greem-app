import 'dart:convert';
import 'dart:math';

import 'package:greem/models/token.dart';
import 'package:greem/models/user.dart';
import 'package:greem/utils/api.dart';
import 'package:http/http.dart' as http;

class AuthRepository extends APIService {
  String _baseURL = 'http://localhost:3000';
  String _baseAuthURL = 'http://localhost:4000/auth';

  AuthRepository({super.tokens});

  Future<dynamic> registerUser(
      {required String? username,
      required String? email,
      required String? password}) async {
    Uri uri = Uri.parse('$_baseAuthURL/register');
    try {
      http.Response response = await post(
        uri: uri,
        body: {"username": username, "email": email, "password": password},
      );
      if (!(response.statusCode == 201)) {
        throw jsonDecode(response.body)["error_description"];
      }
      Object jsonData = jsonDecode(response.body);
      return AuthUser.fromJson(jsonData);
    } catch (e) {
      rethrow;
    }
  }

  Future<Tokens?> loginUser(
      {required String email, required String password}) async {
    Uri uri = Uri.parse('$_baseAuthURL/login');

    try {
      http.Response response = await post(
        uri: uri,
        body: {"email": email, "password": password},
      );

      if (!(response.statusCode == 200)) {
        ;
        throw jsonDecode(response.body)["error_description"];
      }
      Object jsonData = jsonDecode(response.body);

      Tokens tokens = Tokens.fromJson(jsonData);
      
      await tokens.localSave();

      return tokens;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    Uri uri = Uri.parse('$_baseAuthURL/logout');

    try {
      http.Response response = await super
          .delete(uri: uri, body: {"refreshTokens": tokens!.refreshToken});

      await tokens!.deleteLocalTokens();
    } catch (e) {
      rethrow;
    }
  }

  //  String _getPathURL(path) {
  //   return '${_baseURL + path};
  // }
}