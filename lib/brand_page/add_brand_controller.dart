import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/add_brand_model.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/util/getListsController.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class AddBrandController {
  // Key
  final formKey = GlobalKey<FormState>();
  final TextEditingController brandName = TextEditingController();
  String? id;
  String? token;
  String? brandImage;
  final dio = Dio();
  final getAllListsController = GetListsController();

  // Adding Comfirm
  Future<void> addBrand(BuildContext context, String categoryId) async {
    final allBrand = Provider.of<AllBrandData>(context, listen: false);
    final addBrand = Provider.of<AddBrandModel>(context, listen: false);

    brandImage = addBrand.imageStr;
    // getting id and token
    idAndToken(context);
    // getting id and toke

    if (allBrand.allBrandList.isEmpty) {
      await getAllListsController.getBrandList(
        context: context,
        brandModel: allBrand,
      );
    }

    final String url = "$mainUrl/brands?admin_id=$id";
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

  // If category list is not fetched already, go to fetch
  Future<void> checkCategoryList(BuildContext context) async {
    final allCategoryModel =
        Provider.of<AllCategoryData>(context, listen: false);
    final allList = GetListsController();

    if (allCategoryModel.allCategoriesList.isEmpty) {
      await allList.getCategoryList(
          context: context, categoryModel: allCategoryModel);
    }
  }

  // Brand Name Validation
  String? validateBrandName(String? input) {
    if (input!.isEmpty) {
      return "* Type Something";
    }
    return null;
  }
}
