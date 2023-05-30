import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/Authentication/sign_up_screen.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';

class LogOutController {
  final dio = Dio();

  final signUpController = SignUpFormController();

  Future<void> logOut(BuildContext context) async {
    idAndToken(context);
    final String url = "$mainUrl/logout?admin_id=$adminId";

    final response = await dio.post(
      url,
      options: Options(
        headers: {
          "authorization": "Bearer $token",
        },
        contentType: Headers.jsonContentType,
      ),
    );

    try {
      if (response.statusCode == 200 &&
          response.data['error'].toString() == "false" &&
          response.data['authorize'].toString() == "true") {
        Future.microtask(
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SignUp(),
              ),
            );
            signUpController.showSnackBar(
              context,
              response.data['message'].toString(),
            );
          },
        );
      } else if (response.data['message'].toString().isNotEmpty) {
        signUpController.showSnackBar(
          context,
          response.data['message'].toString(),
        );
      } else {
        signUpController.showSnackBar(context, "Server Error");
      }
    } on DioError catch (_) {
      signUpController.showSnackBar(context, "Something Wrong");
    }
  }
}
