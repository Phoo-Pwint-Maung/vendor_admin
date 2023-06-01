import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/business_page/update_business/update_business_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
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

  List updateBrandList = [];
  List updateCategoryList = [];

  int selectedBusinessData(BuildContext context, String id) {
    final allBusinessData =
        Provider.of<AllBusinessData>(context, listen: false);
    final updateBusinessModel =
        Provider.of<UpdateBusinessModel>(context, listen: false);
    int selectedIndex = allBusinessData.allBusinessList.indexWhere((element) {
      return element.businessId == id;
    });

    updateBusinessModel.keepSelectedIndex(selectedIndex);

    updateBusinessModel.keepSelectedBrandList(
        allBusinessData.allBusinessList[selectedIndex].brand);
    updateBusinessModel.keepSelectedCategoryList(
        allBusinessData.allBusinessList[selectedIndex].category);

    selectedName = allBusinessData.allBusinessList[selectedIndex].name;
    selectedAddress = allBusinessData.allBusinessList[selectedIndex].address;

    businessName = TextEditingController(text: selectedName);
    businessAddress = TextEditingController(text: selectedAddress);

    return selectedIndex;
  }

  Future<void> updateBusiness(
    BuildContext context,
    String id,
    List<AllCategoryModel> updatedCategoryList,
    List<AllBrandModel> updatedBrandList,
  ) async {
    print("start");
    final selectedBusinessId = id;
    final updateBusinessModel =
        Provider.of<UpdateBusinessModel>(context, listen: false);
    final allBusinessModel =
        Provider.of<AllBusinessData>(context, listen: false);

    // Get Id and Token From Signin or Singup
    idAndToken(context);

    if (updatedBrandList.isEmpty) {
      updateBrandList = updateBusinessModel.selectedBrandList!;
    } else {
      // brand list
      for (var i = 0; i < updatedBrandList.length; i++) {
        updateBrandList.add(
          {
            "id": updatedBrandList[i].brandId,
            "name": updatedBrandList[i].brandName
          },
        );
      }
    }

    if (updatedCategoryList.isEmpty) {
      updateCategoryList = updateBusinessModel.selectedCategoryList!;
    } else {
      // category list
      for (var i = 0; i < updatedCategoryList.length; i++) {
        updateCategoryList.add(
          {
            "id": updatedCategoryList[i].categoryId,
            "name": updatedCategoryList[i].categoryName
          },
        );
      }
    }

    if (updateBusinessModel.imageStr == null &&
        selectedName == businessName.text &&
        selectedAddress == businessAddress.text &&
        updatedCategoryList.isEmpty &&
        updatedBrandList.isEmpty) {
      signUpController.showSnackBar(context, "* You Didn't Change Anything");
    } else if (updateBusinessModel.imageStr != null ||
        selectedName != businessName.text ||
        selectedAddress != businessAddress.text ||
        updatedBrandList.isNotEmpty ||
        updatedCategoryList.isNotEmpty) {
      print(updateBusinessModel.imageStr);
      final body = {
        "name": businessName.text,
        "address": businessAddress.text,
        "media": updateBusinessModel.imageStr,
        "category": updateCategoryList,
        "brand": updateBrandList
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
          final returnList = response.data["data"];
          AllBusinessModel updatedBusinessData = AllBusinessModel(
              name: returnList["name"].toString(),
              address: returnList["address"].toString(),
              businessId: returnList["_id"].toString(),
              mediaId: returnList["media"]["id"].toString(),
              mediaUrl: returnList["media"]["media_link"].toString(),
              category: returnList["category"],
              brand: returnList["brand"],
              status: returnList["status"].toString());
          allBusinessModel.editBusiness(id, updatedBusinessData);
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
