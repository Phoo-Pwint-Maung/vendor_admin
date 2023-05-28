import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class DeleteCategoryController {
  String? adminId;
  String? token;

  Future<void> deleteBusiness(BuildContext context, String categoryId) async {
    final allCategoryModel =
        Provider.of<AllCategoryData>(context, listen: false);

    // Get Id and Token From Signin or Singup
    List<String> idTokenList = idAndToken(context);
    adminId = idTokenList[0];
    token = idTokenList[1];

    final url = "$mainUrl/categories/$categoryId?admin_id=$adminId";

    final response = await dio.delete(
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
        allCategoryModel.deleteCategory(categoryId);
      }
    } catch (e) {}

    print(response);
  }
}
