import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/add_brand_model.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class AddBrandController {
  // Key
  final formKey = GlobalKey<FormState>();
  final TextEditingController brandName = TextEditingController();

  String? brandImage;

  final scroll = ScrollController();

  // Adding Comfirm
  Future<void> addBrand(BuildContext context, String categoryId) async {
    final allBrand = Provider.of<AllBrandData>(context, listen: false);
    final addBrand = Provider.of<AddBrandModel>(context, listen: false);

    brandImage = addBrand.imageStr;

    final String url = "$mainUrl/brands?admin_id=$adminId";
    final body = {
      "category_id": categoryId,
      "name": brandName.text,
      "media": brandImage,
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

    try {
      if (response.statusCode == 200 &&
          response.data["error"].toString() == "false") {
        final responseList = response.data["data"];
        // Adding Create Success data to AllCategoryModel
        allBrand.addNewBrand(
          AllBrandModel(
            brandId: responseList["_id"].toString(),
            brandName: responseList["name"].toString(),
            brandMedia: responseList["media"]["media_link"].toString(),
            mediaId: responseList["media"]["id"].toString(),
            categoryId: responseList["category_id"].toString(),
          ),
        );
      }
    } catch (e) {}
  }

  // Brand Name Validation
  String? validateBrandName(String? input) {
    if (input!.isEmpty) {
      return "* Type Something";
    }
    return null;
  }
}
