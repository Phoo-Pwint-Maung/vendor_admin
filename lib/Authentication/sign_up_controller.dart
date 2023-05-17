import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/home_page/main_scaffold.dart';

class SignUpFormController {
  final dio = Dio();
  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  // ScrollController
  final scroll = ScrollController();
  // Key
  final formKey = GlobalKey<FormState>();

  // Email Validation
  String? validateEmail(String? input) {
    if (input!.isEmpty) {
      return "* Type Something";
    } else if (input.endsWith('@gmail.com')) {
      return null;
    }
    return " * Ends with  '@gmail.com' ";
  }

  // Password Validation
  String? validatePassword(String? input) {
    if (input!.isEmpty) {
      return "* Type Something";
    } else if (input.length > 8) {
      return "Password allows only 8 characters";
    } else if (input.contains(" ")) {
      return "Space not allow";
    } else {
      return null;
    }
  }

// Post Api
  Future<void> postData(
      TextEditingController name,
      TextEditingController username,
      TextEditingController email,
      TextEditingController password,
      BuildContext context) async {
    final nameText = name.text;
    final usernameText = username.text;
    final emailText = email.text;
    final passwordText = password.text;

    final body = {
      "name": nameText,
      "username": usernameText,
      "email": emailText,
      "password": passwordText,
    };

    String url = "$mainUrl/register";

    final response = await dio.post(
      url,
      data: body,
      options: Options(
        contentType: Headers.jsonContentType,
      ),
    );

    if (response.statusCode == 200) {
      print("successful register");
      if (context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScaffold(),
        ),
      );
    } else if (response.statusCode == 500) {
      print("internal server error");
    }
  }
}
