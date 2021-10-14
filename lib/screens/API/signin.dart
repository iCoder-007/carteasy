import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../constants.dart';

class SignIn {
  static Future<List<dynamic>> signIn(username) async {
    var uri = Uri.parse('$requestUrl/buy/signIn');
    var response = await http.post(uri,
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
        body: json.encode({'username': username, 'role': 'Consumer'}));
    if (response.statusCode == 200) {
      storeString('token',
          json.decode(utf8.decode(response.bodyBytes))['Response']['token']);
      storeString('username',
          json.decode(utf8.decode(response.bodyBytes))['Response']['username']);
    }
    return [];
  }
}

class SignInStatus {
  static Future<List<dynamic>> signInStatus(username) async {
    final response = await http.post('$requestUrl/buy/signInStatus',
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
        body: json.encode({'username': username}));
    return [response.statusCode];
  }
}
