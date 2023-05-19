import 'package:flutter/material.dart';
import 'package:vendor_admin/Authentication/sign_in_screen.dart';

class SignInData {
  String id;
  String name;
  String email;
  String authToken;

  SignInData(
      {required this.id,
      required this.name,
      required this.email,
      required this.authToken});
}

class SignInModel extends ChangeNotifier {
  var id = '';
  var name = '';
  var email = '';
  var signInAuthToken = '';

  void keepData(SignInData data) {
    id = data.id.toString();
    name = data.name.toString();
    email = data.email.toString();
    signInAuthToken = data.authToken.toString();

    print("thi is token in model $signInAuthToken");
    notifyListeners();
  }
}
