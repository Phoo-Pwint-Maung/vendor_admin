import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/business_page/add_business_model.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class AddBusinessController {
  final formKey = GlobalKey<FormState>();
  final businessName = TextEditingController();
  final businessAddress = TextEditingController();

  Future<void> addNewBusiness(BuildContext context,
      List<AllCategoryModel> category, List<AllBrandModel> brand) async {
    print("start Posting");
    List<Map<String, String>> addCategory = [];
    List<Map<String, String>> addBrand = [];
    final addBusinessModel =
        Provider.of<AddBusinessModel>(context, listen: false);
    final allBusinessModel =
        Provider.of<AllBusinessData>(context, listen: false);

    // Get Id and Token From Signin or Singup
    idAndToken(context);
    print(allBusinessModel.allBusinessList.length);

    // category list
    for (var i = 0; i < category.length; i++) {
      addCategory.add(
        {"id": category[i].categoryId, "name": category[i].categoryName},
      );
    }
    // brand list
    for (var i = 0; i < brand.length; i++) {
      addBrand.add(
        {"id": brand[i].brandId, "name": brand[i].brandName},
      );
    }

    final url = "$mainUrl/businesses?admin_id=$adminId";

    if (addBusinessModel.imageStr != null) {
      final body = {
        "name": businessName.text,
        "address": businessAddress.text,
        "media": addBusinessModel.imageStr,
        "category": addCategory,
        "brand": addBrand
      };
      print(body);
      try {
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

        if (response.statusCode == 200 &&
            response.data["error"].toString() == "false") {
          final returnList = response.data["data"];

          allBusinessModel.addBusiness(
            AllBusinessModel(
              name: returnList["name"].toString(),
              address: returnList["address"].toString(),
              businessId: returnList["_id"].toString(),
              mediaId: returnList["media"]["id"].toString(),
              mediaUrl: returnList["media"]["media_link"].toString(),
              category: returnList["category"],
              brand: returnList["brand"],
              status: returnList["status"].toString(),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  // Brand Name Validation
  String? validateTextFormField(String? input) {
    if (input!.isEmpty) {
      return "* Type Something";
    }
    return null;
  }
}
