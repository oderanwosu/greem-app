import 'dart:convert';

import 'package:greem/utils/api.dart';

import '../models/token.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserDataRepository extends APIService {
  final String _baseURL = 'http://localhost:3000';
 

  UserDataRepository({super.tokens});

  Future<AppUser?> getUser(String username) async {
    Uri uri = Uri.parse('$_baseURL/$username');
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
}
