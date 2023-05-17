import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

final dio = Dio();

class HomeController {
  final scroll = ScrollController();
}

class LogOut {
  final url = "$mainUrl/user/list";
  final username = SignUpFormController().username.text;
  Future<void> getUserList() async {
    print("get user list");
    final response = await dio.get(url);

    final adminList = response.data["data"];

    for (var data in adminList) {
      print(data["name"]);
    }
  }
}
