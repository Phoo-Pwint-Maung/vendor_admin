import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/Authentication/model/sign_up_model.dart';

String id = "";
String token = "";
List<String> idAndToken(BuildContext context) {
  final signInData = Provider.of<SignInData>(context, listen: false);
  final signUpData = Provider.of<SignUpData>(context, listen: false);

  signUpData.fromSignUp ? id = signUpData.id : id = signInData.id;
  signUpData.fromSignUp
      ? token = signUpData.signUpAuthToken
      : token = signInData.signInAuthToken;

  List<String> idTokenList = [id, token];

  return idTokenList;
}
