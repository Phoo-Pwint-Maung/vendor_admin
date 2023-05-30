import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';

String adminId = "";
String token = "";
void idAndToken(BuildContext context) {
  final signInData = Provider.of<SignInData>(context, listen: false);

  adminId = signInData.id;
  token = signInData.signInAuthToken;
}
