import 'package:flutter/material.dart';

class SignInModel {
  String id;
  String name;
  String email;
  String authToken;

  SignInModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.authToken});
}

class SignInData extends ChangeNotifier {
  var id = '';
  var name = '';
  var email = '';
  var signInAuthToken = '';

  void keepData(SignInModel data) {
    id = data.id.toString();
    name = data.name.toString();
    email = data.email.toString();
    signInAuthToken = data.authToken.toString();

    notifyListeners();
  }
}
