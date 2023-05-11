import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/api_test/controller/api.dart';
import 'package:vendor_admin/provider/providers.dart';
import 'package:vendor_admin/Authentication/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
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
      home: SignUp(),
    );
  }
}
