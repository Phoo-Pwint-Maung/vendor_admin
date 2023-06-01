import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/home_page/home_controller.dart';

class VendorManageController {
  final scroll = ScrollController();

  Future<void> activeToInactiveFunction(
      BuildContext context, String selectedId) async {
    print("active to inactive process");
    // Get Admin id and Token;
    idAndToken(context);

    final url = "$mainUrl/inactive/vendor/process?admin_id=$adminId";

    final response = await dio.post(
      url,
      data: {
        "vendor_id": selectedId,
      },
      options: Options(
        headers: {
          "authorization": "Bearer $token",
        },
        contentType: Headers.jsonContentType,
      ),
    );

    print(response);

    try {
      if (response.statusCode == 200 &&
          response.data["error"].toString() == "false") {
        final message = response.data["message"];
        final singUpController = SignUpFormController();
        singUpController.showSnackBar(context, "Success !! ${message} ");
      }
    } catch (e) {}
  }

  Future<void> inactiveToactiveFunction(
      BuildContext context, String selectedId) async {
    // Get Admin id and Token;
    idAndToken(context);

    final url = "$mainUrl/active/vendor/process?admin_id=$adminId";

    final response = await dio.post(
      url,
      data: {
        "vendor_id": selectedId,
      },
      options: Options(
        headers: {
          "authorization": "Bearer $token",
        },
        contentType: Headers.jsonContentType,
      ),
    );

    try {
      if (response.statusCode == 200 &&
          response.data["error"].toString() == "false") {
        final message = response.data["message"];
        final singUpController = SignUpFormController();
        singUpController.showSnackBar(context, "Success !! ${message} ");
      }
    } catch (e) {}
  }
}
