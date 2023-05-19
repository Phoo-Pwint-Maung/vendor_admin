import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/Authentication/sign_up_screen.dart';

class LogOutController {
  final dio = Dio();
  String id = '';
  String token = '';

  Future<void> logOut(BuildContext context) async {
    final signInData = Provider.of<SignInModel>(context, listen: false);
    id = signInData.id;
    token = signInData.signInAuthToken;
    final String url = "$mainUrl/logout?admin_id=$id";

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
            showSnackBar(
              context,
              response.data['message'].toString(),
            );
          },
        );
      } else if (response.data['message'].toString().isNotEmpty) {
        showSnackBar(
          context,
          response.data['message'].toString(),
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
}
