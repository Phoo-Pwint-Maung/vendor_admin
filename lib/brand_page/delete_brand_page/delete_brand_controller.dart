import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class DeleteBrandController {
  Future<void> deleteBrand(BuildContext context, String brandId) async {
    final allBrandModel = Provider.of<AllBrandData>(context, listen: false);

    // Get Id and Token From Signin or Singup
    idAndToken(context);

    final url = "$mainUrl/brands/$brandId?admin_id=$adminId";

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
        allBrandModel.deleteBrand(brandId);
      }
    } catch (e) {}

    print(response);
  }
}
