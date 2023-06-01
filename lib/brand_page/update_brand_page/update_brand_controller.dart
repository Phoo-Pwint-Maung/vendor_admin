import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/brand_page/update_brand_page/update_brand_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class UpdateBrandController {
  final formKey = GlobalKey<FormState>();

  TextEditingController brandName = TextEditingController();

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

  Future<void> updateBrand(
      BuildContext context, String brandId, String? selectedCategoryId) async {
    final model = Provider.of<UpdateBrandModel>(context, listen: false);
    final allBrandModel = Provider.of<AllBrandData>(context, listen: false);
    // Get Id and Token From Signin or Singup
    idAndToken(context);

    final url = "$mainUrl/brands/$brandId?admin_id=$adminId";

    final body = {
      "category_id": selectedCategoryId,
      "name": brandName.text,
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
        final AllBrandModel updateBrandData = AllBrandModel(
            brandId: responseList["_id"].toString(),
            brandName: responseList["name"].toString(),
            brandMedia: responseList["media"]["media_link"].toString(),
            mediaId: responseList["media"]["id"].toString(),
            categoryId: responseList["category_id"].toString());
        allBrandModel.editBrand(brandId, updateBrandData);
      }
    } catch (e) {}
  }
}
