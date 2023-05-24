
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class AllBrandController {
  String id = "";
  String token = "";
  final dio = Dio();

  Future<void> getAllBrand(BuildContext context) async {
    List<String> idTokenList = idAndToken(context);
    final allBrandModel = Provider.of<AllBrandModel>(context, listen: false);
    id = idTokenList[0];
    token = idTokenList[1];

    if (allBrandModel.allBrandList.isEmpty) {
      final url = "$mainUrl/brands?admin_id=$id";
      final response = await dio.get(
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
          allBrandModel.getAllBrandData(response.data["data"]);
        }
      } catch (e) {}
    } else {}

    return;
  }
}
