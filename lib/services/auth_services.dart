import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_node_auth/models/user.dart';
import 'package:flutter_node_auth/providers/user_provider.dart';
import 'package:flutter_node_auth/screens/home_screen.dart';
import 'package:flutter_node_auth/utils/constant.dart';
import 'package:flutter_node_auth/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: (() {
          showSnackBar(
              context, "Account created! Login with the same credentials");
        }),
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void sinInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      // final User user =
      //     User(id: "", name: "", email: email, token: "", password: password);
      http.Response res = await http.post(
          Uri.parse('${Constants.uri}/api/signup'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: (() async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            await prefs.setString('x-auth-token', jsonDecode(res.body));
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
          }));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
