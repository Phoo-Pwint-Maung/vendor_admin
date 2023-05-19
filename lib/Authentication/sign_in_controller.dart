import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/home_page/main_scaffold.dart';

class SignInFormController {
  final dio = Dio();
  final email = TextEditingController();
  final password = TextEditingController();

  final scroll = ScrollController();

  Future<void> login(BuildContext context) async {
    final String url = "$mainUrl/login";
    final body = {
      "email": email.text,
      "password": password.text,
    };

    final response = await dio.post(
      url,
      data: body,
      options: Options(
        contentType: Headers.jsonContentType,
      ),
    );

    try {
      if (response.statusCode == 200 &&
          response.data['error'].toString() == "false") {
        final id = response.data['data']['_id'].toString();
        final authToken = response.data['data']['auth_token'].toString();
        final name = response.data['data']['name'].toString();
        final email = response.data['data']['email'].toString();

        final signInController =
            Provider.of<SignInModel>(context, listen: false);
        signInController.keepData(
            SignInData(id: id, name: name, email: email, authToken: authToken));

        Future.microtask(
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MainScaffold(),
              ),
            );
          },
        );
      } else if (response.data['message'].toString().isNotEmpty) {
        showSnackBar(
          context,
          response.data["message"].toString(),
        );
      } else {
        showSnackBar(context, "Server Error");
      }
    } on DioError catch (_) {
      showSnackBar(context, "Something Wrong");
    }
  }

  void showSnackBar(BuildContext context, String errMessage) {
    final snackBar = SnackBar(
      content: Text(errMessage),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
      return "Password must be at least 8 characters";
    } else if (input.length < 8) {
      return "Password must be at least 8 characters";
    } else if (input.contains(" ")) {
      return "Space not allow";
    } else {
      return null;
    }
  }
}
