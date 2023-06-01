import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class DeleteBusinessController {
  int selectedItemIndex({required AllBusinessData data, required String id}) {
    return data.allBusinessList.indexWhere((element) {
      return element.businessId == id;
    });
  }

  Future<void> deleteBusiness(BuildContext context, String id) async {
    final allBusinessModel =
        Provider.of<AllBusinessData>(context, listen: false);

    // Get Id and Token From Signin or Singup
    idAndToken(context);

    final businessId = id;

    final url = "$mainUrl/businesses/$businessId?admin_id=$adminId";

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
        allBusinessModel.deleteBusiness(businessId);
      }
    } catch (e) {}

    print(response);
  }
}
