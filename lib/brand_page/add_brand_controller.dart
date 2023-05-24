import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/add_brand_model.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';
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

  // Adding Comfirm

  Future<void> addBrand(BuildContext context) async {
    final addBrandModel = Provider.of<AddBrandModel>(context, listen: false);
    final allBrandModel = Provider.of<AllBrandModel>(context, listen: false);

    // getting id and token
    List<String> listIdAndToken = idAndToken(context);
    id = listIdAndToken[0];
    token = listIdAndToken[1];
    // getting id and token

    print(addBrandModel.choosedImage);

    if (addBrandModel.imageStr != null) {
      brandImage = addBrandModel.imageStr;
      // File file = File(addBrandModel.choosedImage!.path);

      // List<int> unit8 = file.readAsBytesSync();

      // brandImage = base64Encode(unit8);
      // print(brandImage);
    }

    final String url = "$mainUrl/brands?admin_id=$id";
    final body = {
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
        print(response);
        // allBrandModel.getAllBrandData(response.data["data"]);
      }
    } catch (e) {}
  }

  // showPreView Choosed Image
  Widget showPreviewImage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final addBrandModel = Provider.of<AddBrandModel>(context);
    return addBrandModel.choosedImage == null
        ? Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            width: screenWidth * 0.45,
            child: Image.asset("assets/images/brandImage.png"),
          )
        : Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            width: screenWidth * 0.45,
            child: Image.file(
              File(addBrandModel.choosedImage!.path),
            ),
          );
  }

  // Brand Name Validation
  String? validateBrandName(String? input) {
    if (input!.isEmpty) {
      return "* Type Something";
    }
    return null;
  }

  Widget showNoImageError(BuildContext context) {
    final color = ColorConst();
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.4,
      child: Text(
        "*Choose Image*",
        style: TextStyle(
          color: color.secondaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
