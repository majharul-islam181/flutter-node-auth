import 'package:flutter/material.dart';
import 'package:flutter_node_auth/models/user.dart';
import 'package:flutter_node_auth/utils/utils.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(id: "", name: "", email: "", token: "", password: "");
      http.Response res = await http.post(
          Uri.parse('${Constants.uri}/api/signup'),
          body: user.toJson(),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'});

          httpErrorHandle(response: response, context: context, onSuccess: onSuccess)
    } catch (e) {

    }
  }
}
