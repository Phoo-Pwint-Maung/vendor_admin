import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/home_page/main_scaffold.dart';

class SignInFormController {
  final dio = Dio();
  final name = TextEditingController();
  final email = TextEditingController();

  final scroll = ScrollController();

  // / Post Api
  Future<void> postData(TextEditingController name, TextEditingController email,
      BuildContext context) async {
    final nameText = name.text;
    final emailText = email.text;

    final body = {
      "name": nameText,
      "email": emailText,
    };

    String url = "$mainUrl/login";

    final response = await dio.post(
      url,
      data: body,
      options: Options(
        contentType: Headers.jsonContentType,
      ),
    );

    if (response.statusCode == 200) {
      print("successful register");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScaffold(),
        ),
      );
    } else if (response.statusCode == 500) {
      print("internal server error");
    }
  }
}
