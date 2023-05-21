import 'package:flutter/material.dart';

class SignUpModel {
  final String id;
  final String name;
  final String email;
  final String authToken;

  SignUpModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.authToken});
}

class SignUpData extends ChangeNotifier {
  var id = '';
  var name = '';
  var email = '';
  var signUpAuthToken = '';
  var fromSignUp = false;

  void keepData(SignUpModel data) {
    id = data.id.toString();
    name = data.name.toString();
    email = data.email.toString();
    signUpAuthToken = data.authToken.toString();
    fromSignUp = true;
    notifyListeners();
  }
}
