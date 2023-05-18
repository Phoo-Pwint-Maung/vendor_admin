import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_up_model.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class SignUpFormController {
  final dio = Dio();
  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  // ScrollController
  final scroll = ScrollController();
  // Key
  final formKey = GlobalKey<FormState>();
  // Model
  final signUpModel = SignUpModel();

  Future<void> register() async {
    final String url = "$mainUrl/register";
    final body = {
      "name": name.text,
      "email": email.text,
      "password": password.text
    };

    final response = await dio.post(
      url,
      data: body,
      options: Options(
        contentType: Headers.jsonContentType,
      ),
    );

    if (response.data['error'] == true) {
      print(response.data);
      print(response.data['error']);
      print(response.data['data']['email']);
      signUpModel.isError(response.data['data']['email'][0]);
    }
  }

  void showErrorMessage(String error, BuildContext context) {
    final snackBar = SnackBar(content: Text(error));
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
      return "Password must be 8 characters";
    } else if (input.length < 8) {
      return "Password must be 8 characters";
    } else if (input.contains(" ")) {
      return "Space not allow";
    } else {
      return null;
    }
  }

// Post Api
  // Future<void> postData(
  //   TextEditingController name,
  //   TextEditingController email,
  //   TextEditingController password,
  //   BuildContext context,
  // ) async {
  //   final nameText = name.text;

  //   final emailText = email.text;
  //   final passwordText = password.text;

  //   final body = {
  //     "name": nameText,
  //     "email": emailText,
  //     "password": passwordText,
  //   };

  //   String url = "$mainUrl/register";

  //   final response = await dio.post(
  //     url,
  //     data: body,
  //     options: Options(
  //       contentType: Headers.jsonContentType,
  //     ),
  //   );

  //   print(response);

  //   if (response.statusCode == 200) {
  //     print("successful register");
  //     if (context.mounted) return;
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const MainScaffold(),
  //       ),
  //     );
  //   } else if (response.statusCode == 500) {
  //     print("internal server error");
  //   }
  // }
}
