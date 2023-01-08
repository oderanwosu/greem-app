import 'dart:convert';
import 'dart:io';
import 'package:greem/models/token.dart';
import 'package:greem/providers/auth_providers.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

import '../providers/routes_provider.dart';

class APIService {
  Tokens? tokens;
  Ref ref;

  APIService({this.tokens, required this.ref});

  _errorCheck(response) async {
    if (jsonDecode(response.body)["error_description"] != null) return true;
    return false;
  }

  getHeader(bool? requireToken) {
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    requireToken != null && requireToken == true
        ? headers.putIfAbsent(HttpHeaders.authorizationHeader,
            () => 'Bearer ${ref.watch(tokensProvider).token!}')
        : null;

    return headers;
  }

  Future<http.Response> post(
      {required uri, required Object body, bool? requireToken}) async {
    var headers = getHeader(requireToken);

    try {
      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      if (response.statusCode != 200 && response.statusCode != 201) {
        if (jsonDecode(response.body)["error"] != 'invalid token') {
          throw jsonDecode(response.body)["error_description"];
        }
        await refreshToken();
        response = await post(uri: uri, body: body, requireToken: requireToken);
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> delete(
      {required Uri uri, Object? body, bool? requireToken}) async {
    var headers = getHeader(requireToken);
    try {
      http.Response response =
          await http.delete(uri, body: jsonEncode(body), headers: headers);

      if (response.statusCode != 204) {
        if (jsonDecode(response.body)["error"] != 'invalid token') {
          throw jsonDecode(response.body)["error_description"];
        }
        await refreshToken();
        response =
            await delete(uri: uri, body: body, requireToken: requireToken);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> get({required Uri uri, bool? requireToken}) async {
    var headers = getHeader(requireToken);

    try {
      http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode != 200) {
        print(
            '${response.request} ${response.statusCode} ${jsonDecode(response.body)["error"]} ');
        if (jsonDecode(response.body)["error"] != 'invalid token') {
          print('hi');
          throw jsonDecode(response.body)["error_description"];
        }
        await refreshToken();
        response = await get(uri: uri, requireToken: requireToken);
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshToken() async {
    var headers = await getHeader(false);
    try {
      http.Response response = await http.post(
          Uri.parse('http://localhost:4000/auth/new_token'),
          body: jsonEncode({"refreshToken": tokens!.refreshToken}),
          headers: headers);
      if (response.statusCode != 200) {
        if (jsonDecode(response.body)["error"] == 'invalid token') {
          await ref.read(tokensProvider).deleteLocalTokens();
          ref.read(routeRefreshProvider).refresh();
          return;
        }
      }

      await ref
          .read(tokensProvider)
          .setNewToken(jsonDecode(response.body)['accessToken']);
    } catch (e) {
      rethrow;
    }
  }
}
