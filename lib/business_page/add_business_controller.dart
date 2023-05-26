import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/business_page/add_business_model.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class AddBusinessController {
  final formKey = GlobalKey<FormState>();
  final businessName = TextEditingController();
  final businessAddress = TextEditingController();

  Future<void> addNewBusiness(BuildContext context) async {
    print("start Posting");

    final addBusinessModel =
        Provider.of<AddBusinessModel>(context, listen: false);
    final allBusinessModel =
        Provider.of<AllBusinessData>(context, listen: false);

    addBusinessModel.addNewBusiness == null;

    // Get Id and Token From Signin or Singup
    List<String> idTokenList = idAndToken(context);
    id = idTokenList[0];
    token = idTokenList[1];

    final url = "$mainUrl/businesses?admin_id=$id";

    if (addBusinessModel.imageStr != null) {
      final body = {
        "name": businessName.text,
        "address": businessAddress.text,
        "media": addBusinessModel.imageStr,
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
          final returnList = response.data["data"];
          AllBusinessModel model = AllBusinessModel(
            name: returnList["name"],
            address: returnList["address"],
            businessId: returnList["_id"],
            mediaId: returnList["media"]["id"],
            mediaUrl: returnList["media"]["media_link"],
          );

          addBusinessModel.getAddBusinessData(model);

          allBusinessModel.allList.add(model);
        }
      } catch (e) {}
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
