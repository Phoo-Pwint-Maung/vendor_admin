import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/category_page/update_category/update_category_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class UpdateCategoryController {
  final formKey = GlobalKey<FormState>();

  TextEditingController categoryName = TextEditingController();

  final ScrollController scroll = ScrollController();

  // Category Name Validation
  String? validateCategoryName(String? input) {
    if (input!.isEmpty) {
      return "* Type Something *";
    } else if (input.length > 30) {
      return "* Only 30 characters Allow *";
    }
    return null;
  }

  Future<void> updateCategory(BuildContext context, String categoryId) async {
    final model = Provider.of<UpdateCategoryModel>(context, listen: false);
    final allCategoryModel =
        Provider.of<AllCategoryData>(context, listen: false);
    // Get Id and Token From Signin or Singup
    idAndToken(context);

    final url = "$mainUrl/categories/$categoryId?admin_id=$adminId";

    final body = {
      "name": categoryName.text,
      "media": model.imageStr,
    };
    print(body);
    final response = await dio.put(
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
        final AllCategoryModel updateCategoryData = AllCategoryModel(
          categoryId: responseList["_id"].toString(),
          categoryName: responseList["name"].toString(),
          categoryMedia: responseList["media"]["media_link"].toString(),
          mediaId: responseList["media"]["id"].toString(),
          status: responseList["status"].toString(),
        );
        allCategoryModel.editCategory(categoryId, updateCategoryData);
        // Adding Create Success data to AllCategoryModel
      }
    } catch (e) {}
  }
}
