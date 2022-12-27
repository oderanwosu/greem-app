import 'dart:convert';
import 'dart:io';
import 'package:greem/models/token.dart';
import 'package:http/http.dart' as http;

class APIService {
  Tokens? tokens;

  APIService({this.tokens});
  Future<http.Response> post(
      {required uri, required Object body, bool? requireToken}) async {
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (requireToken == true) {
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer ${tokens!.token}');
    }

    return await http.post(
      uri,
      body: jsonEncode(body),
      headers: headers,
    );
  }

  Future<http.Response> delete(
      {required Uri uri, Object? body, bool? requireToken}) async {
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (requireToken == true) {
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer ${tokens!.token}');
    }
    return await http.delete(uri, body: jsonEncode(body), headers: headers);
  }

  Future<http.Response> get(
      {required Uri uri, bool? requireToken}) async {
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (requireToken == true) {
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer ${tokens!.token}');
    }
    return await http.get(uri, headers: headers);
  }
}
