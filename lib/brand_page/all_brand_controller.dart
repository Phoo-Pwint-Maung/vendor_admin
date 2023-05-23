import 'dart:convert';

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

  void getAllBrand(BuildContext context) async {
    List<String> idTokenList = idAndToken(context);
    final allBrandModel = Provider.of<AllBrandModel>(context, listen: false);

    id = idTokenList[0];
    token = idTokenList[1];

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

    // Error Handling Left

    // Error Handling Left

    final resultEncodeString = jsonEncode(response.data);
    final resultDecode = jsonDecode(resultEncodeString);
    // Putting Result to Model Map<String,dynamic>
    allBrandModel.getAllBrand(resultDecode);
  }

  void showAllBrand(BuildContext context) {
    final allBrandModel = Provider.of<AllBrandModel>(context, listen: false);
    print(allBrandModel.nameList);
    print(allBrandModel.idList);

    // final allBrand = allBrandModel.allBrand;

    // print(allBrand["data"]);

    // for (var i = 0; i < allBrand["count"]; i++) {
    //   print(allBrand["data"][i]["_id"]);

    //   print(allBrand["data"][i]["name"]);
    //   print(allBrand["data"][i]["media"]["id"]);
    //   print(allBrand["data"][i]["media"]["media_link"]);
    // }
  }
}
