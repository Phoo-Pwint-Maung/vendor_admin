import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/home_page/home_controller.dart';

class AllBusinessController {
  final scroll = ScrollController();
  String? id;
  String? token;
  Future<void> getAllBusiness(BuildContext context) async {
    final allBusinessModel =
        Provider.of<AllBusinessData>(context, listen: false);
    if (allBusinessModel.allBusinessList.isEmpty) {
      print("Start to get all business");
      // Get Id and Token From Signin or Singup
      List<String> idTokenList = idAndToken(context);
      id = idTokenList[0];
      token = idTokenList[1];

      // if No data in first time , get data from api

      print("get");
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
      print(id);
      print(token);
      print(response);

      try {
        if (response.statusCode == 200 &&
            response.data["error"].toString() == "false") {
          final List<dynamic> list = response.data["data"];
          print(list);
          if (response.data["count"].toString() == "0") {
            print("No Business");
          }
          // Keep Data in Modle
          allBusinessModel.allBusinessData(list);
        }
      } catch (e) {}
    } else {
      print("no api call");
    }
  }
}
