import 'package:flutter/material.dart';

class PassChangeModel extends ChangeNotifier {
  Map<String, dynamic> passwordError = {};
  void isPasswordError(Map<String, dynamic> error) {
    passwordError = error;
    notifyListeners();
  }
}
