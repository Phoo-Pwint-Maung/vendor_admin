import 'package:flutter/material.dart';
import 'package:vendor_admin/Authentication/sign_up_screen.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/provider/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: provider,
      child: MaterialApp(
        scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SignUp(),
      ),
    );
  }
}
