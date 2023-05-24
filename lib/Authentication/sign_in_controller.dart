import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/home_page/main_scaffold.dart';

class SignInFormController {
  final dio = Dio();
  final email = TextEditingController();
  final password = TextEditingController();
  final signUpController = SignUpFormController();

  final scroll = ScrollController();

  Future<void> login(BuildContext context) async {
    const String url = "$mainUrl/login";
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
        final String id = response.data['data']['_id'].toString();
        final String authToken = response.data['data']['auth_token'].toString();
        final String name = response.data['data']['name'].toString();
        final String email = response.data['data']['email'].toString();
        // Store Data
        final signInModel = Provider.of<SignInData>(context, listen: false);
        signInModel.keepData(
          SignInModel(
            id: id,
            name: name,
            email: email,
            authToken: authToken,
          ),
        );
        // Navigate to HomeScreen
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
        signUpController.showSnackBar(
          context,
          response.data["message"].toString(),
        );
      } else {
        signUpController.showSnackBar(context, "Server Error");
      }
    } on DioError catch (_) {
      signUpController.showSnackBar(context, "Something Wrong");
    }
  }
}
