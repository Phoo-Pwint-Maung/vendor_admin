import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class AllCategoryController {
  final scroll = ScrollController();

  Future<void> getAllCategoryList(BuildContext context) async {
    // Get Id and Token From Signin or Singup
    List<String> idTokenList = idAndToken(context);
    id = idTokenList[0];
    token = idTokenList[1];

    // All Category Model
    final model = Provider.of<AllCategoryData>(context, listen: false);

    if (model.allCategoriesList.isEmpty) {
      // getting list from api
      final url = "$mainUrl/categories?admin_id=$id";
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            "authorization": "Bearer $token",
          },
          contentType: Headers.jsonContentType,
        ),
      );

      // Error Handling
      try {
        if (response.statusCode == 200 &&
            response.data["error"].toString() == "false") {
          List<dynamic> responseList = response.data["data"];
          List<AllCategoryModel> list = [];

          // If there is No Data in  Response List
          if (responseList.isEmpty) {
            model.getNoList(); // turn 'isNoData' to true;
          } else {
            for (var i = 0; i < responseList.length; i++) {
              list.add(
                AllCategoryModel(
                  catergoryId: responseList[i]["_id"].toString(),
                  categoryName: responseList[i]["name"].toString(),
                  categoryMedia:
                      responseList[i]["media"]["media_link"].toString(),
                  mediaId: responseList[i]["media"]["id"].toString(),
                  status: responseList[i]["status"].toString(),
                ),
              );
            }

            model.getList(list);
          }
        }
      } catch (e) {
        print("why this is here error");
      }
    }
  }
}
