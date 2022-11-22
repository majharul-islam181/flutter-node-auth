import 'package:flutter/material.dart';
import 'package:flutter_node_auth/providers/user_provider.dart';
import 'package:flutter_node_auth/screens/signup_scree.dart';
import 'package:provider/provider.dart';

void main() { 
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> UserProvider()),
  ],
  child: const MyApp(),),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignupScreen(),
    );
  }
}

