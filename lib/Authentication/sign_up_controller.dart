import 'package:flutter/material.dart';

class SignUpFormController {
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
}
