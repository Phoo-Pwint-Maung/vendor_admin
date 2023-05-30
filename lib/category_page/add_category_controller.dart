import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/category_page/add_category_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class AddCategoryController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController categoryName = TextEditingController();
  // Category Name Validation
  String? validateCategoryName(String? input) {
    if (input!.isEmpty) {
      return "* Type Something *";
    } else if (input.length > 30) {
      return "* Only 30 characters Allow *";
    }
    return null;
  }

  // Creating Category
  Future<void> createCategory(BuildContext context) async {
    // Get Id and Token From Signin or Singup
    idAndToken(context);

    final addCategoryModel =
        Provider.of<AddCategoryModel>(context, listen: false);
    final allCategoryModel =
        Provider.of<AllCategoryData>(context, listen: false);

    final url = "$mainUrl/categories?admin_id=$adminId";
    final body = {
      "name": categoryName.text,
      "media": addCategoryModel.imageStr,
    };

    final response = await dio.post(
      url,
      data: body,
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
        final responseList = response.data["data"];
        // Adding Create Success data to AllCategoryModel
        allCategoryModel.addNewCategory(
          AllCategoryModel(
            categoryId: responseList["_id"].toString(),
            categoryName: responseList["name"].toString(),
            categoryMedia: responseList["media"]["media_link"].toString(),
            mediaId: responseList["media"]["id"].toString(),
            status: responseList["status"].toString(),
          ),
        );
      }
    } catch (e) {}
  }
}
