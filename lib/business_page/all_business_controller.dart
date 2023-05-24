import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/home_page/home_controller.dart';

class AllBusinessController {
  void getAllBusiness(BuildContext context) async {
    // Get Id and Token From Signin or Singup
    List<String> idTokenList = idAndToken(context);
    id = idTokenList[0];
    token = idTokenList[1];

    final allBusinessModel =
        Provider.of<AllBusinessModel>(context, listen: false);

    // if No data in first time , get data from api
    if (allBusinessModel.allBusinessList.isEmpty) {
      final url = "$mainUrl/businesses?admin_id=$id";
      final response = await dio.get(
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
            response.data["error"].toString() == "false") {
          final int count = int.parse(response.data["count"].toString());
          final List<dynamic> list = response.data["data"];
          // Keep Data in Modle
          allBusinessModel.allBusinessData(count, list);
        }
      } catch (e) {}
    } else {
      return;
    }
  }
}
