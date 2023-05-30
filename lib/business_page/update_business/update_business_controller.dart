import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/business_page/update_business/update_business_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class UpdateBusinessController {
  final formKey = GlobalKey<FormState>();
  TextEditingController businessName = TextEditingController();
  TextEditingController businessAddress = TextEditingController();
  String? selectedName;
  String? selectedAddress;

  final scroll = ScrollController();

  final signUpController = SignUpFormController();

  List<AllBusinessModel> selectedBusinessData(BuildContext context, String id) {
    final allBusinessData =
        Provider.of<AllBusinessData>(context, listen: false);
    List<AllBusinessModel> selectedList =
        allBusinessData.allBusinessList.where((element) {
      return element.businessId == id;
    }).toList();

    selectedName = selectedList[0].name;
    selectedAddress = selectedList[0].address;

    businessName = TextEditingController(text: selectedName);
    businessAddress = TextEditingController(text: selectedAddress);

    return selectedList;
  }

  Future<void> updateBusiness(BuildContext context, String id) async {
    print("start");
    final selectedBusinessId = id;
    final updateBusinessModel =
        Provider.of<UpdateBusinessModel>(context, listen: false);

    // Get Id and Token From Signin or Singup
    idAndToken(context);

    // Api Call to Update

    // if No data in first time , get data from api

    if (updateBusinessModel.imageStr == null &&
        selectedName == businessName.text &&
        selectedAddress == businessAddress.text) {
      signUpController.showSnackBar(context, "* You Didn't Change Anything");
    } else if (updateBusinessModel.imageStr != null ||
        selectedName != businessName.text ||
        selectedAddress != businessAddress.text) {
      final body = {
        "name": businessName.text,
        "address": businessAddress.text,
        "media": updateBusinessModel.imageStr,
      };
      final url = "$mainUrl/businesses/$selectedBusinessId?admin_id=$adminId";
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
      print(id);
      print(token);
      print(response);

      try {
        if (response.statusCode == 200 &&
            response.data["error"].toString() == "false") {
          Navigator.pop(context);
          updateBusinessModel.isSelectImage = false;
          // final returnList = response.data["data"];
          // AllBusinessModel updatedBusinessData = AllBusinessModel(
          //   name: returnList["name"],
          //   address: returnList["address"],
          //   businessId: returnList["_id"],
          //   mediaId: returnList["media"]["id"],
          //   mediaUrl: returnList["media"]["media_link"],
          // );
          // allBusinessModel.editBusiness(id, updatedBusinessData);
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
