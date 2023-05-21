import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/Authentication/model/sign_up_model.dart';
import 'package:dio/dio.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/profile_setting/password_change/pass_change_model.dart';

class PassChangeController {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final newPasswordComfirmation = TextEditingController();
  // Key
  final formKey = GlobalKey<FormState>();
  final dio = Dio();

  final signUpController = SignUpFormController();

  // color
  final color = ColorConst();

  String id = '';
  String token = '';

  void passwordChanged(BuildContext context) async {
    print("start");
    final signInData = Provider.of<SignInData>(context, listen: false);
    final signUpData = Provider.of<SignUpData>(context, listen: false);
    final model = Provider.of<PassChangeModel>(context, listen: false);
    signUpData.fromSignUp ? id = signUpData.id : id = signInData.id;
    signUpData.fromSignUp
        ? token = signUpData.signUpAuthToken
        : token = signInData.signInAuthToken;
    final String url = "$mainUrl/change/password?admin_id=$id";

    final body = {
      "old_password": oldPassword.text,
      "new_password": newPassword.text,
      "new_password_confirmation": newPasswordComfirmation.text,
    };
    print("posting");
    final response = await dio.post(
      url,
      data: body,
      options: Options(
        headers: {
          "authorization": "Bearer $token",
        },
        contentType: Headers.jsonContentType,
      ),
    );

    try {
      if (response.statusCode == 200 &&
          response.data['error'].toString() == "false") {
        print("success");
        model.passwordError = {};
        final String successMessage = response.data['message']
            .toString(); // "Password changed successfully"
        oldPassword.clear();
        newPassword.clear();
        newPasswordComfirmation.clear();
        signUpController.showSnackBar(context, successMessage);
      } else if (response.data['error'].toString() == "true" &&
          response.data['message'].toString() != "Validation errors") {
        print("old password wronf");
        signUpController.showSnackBar(
          context,
          response.data['message'].toString(),
        );
      } else if (response.data['message'].toString() == "Validation errors") {
        print("error");
        final encode = jsonEncode(response.data['data']);
        final Map<String, dynamic> decode = jsonDecode(encode);
        model.isPasswordError(decode);
      }
    } on DioError catch (_) {
      signUpController.showSnackBar(context, "Something Wrong");
    }
  }

  SizedBox errorBox(BuildContext context) {
    final model = Provider.of<PassChangeModel>(context, listen: false);

    return SizedBox(
      // Add your desired properties for the SizedBox here
      child: Column(
        children: [
          ...model.passwordError.values.map((e) {
            return Text(
              "* $e",
              style: TextStyle(
                color: color.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ],
      ),
    );
  }
}
