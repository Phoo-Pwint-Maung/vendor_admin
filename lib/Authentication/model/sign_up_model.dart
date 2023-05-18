import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  bool error = false;
  String emailError = '';

  void isError(String emailErr) {
    emailError = emailErr;
    error = true;
    print("here is model error");
    notifyListeners();
  }
}
