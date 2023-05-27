import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/home_page/home_controller.dart';
import 'package:vendor_admin/vendor_manage_page/vendor_manage_model.dart';

class VendorManageController {
  final scroll = ScrollController();
  String? id;
  String? token;
  Future<void> getAllVendorList(BuildContext context) async {
    // Get Admin id and Token;
    List<String> idTokenList = idAndToken(context);
    id = idTokenList[0];
    token = idTokenList[1];

    final vendorManageModel =
        Provider.of<VendorManageModel>(context, listen: false);

    if (vendorManageModel.activeVendorList.isEmpty &&
        vendorManageModel.inactiveVendorList.isEmpty) {
      // Get Active Vendor List
      final activeUrl = "$mainUrl/active/vendor-lists?admin_id=$id";
      final activeResponse = await dio.get(
        activeUrl,
        options: Options(
          headers: {
            "authorization": "Bearer $token",
          },
          contentType: Headers.jsonContentType,
        ),
      );
      try {
        if (activeResponse.statusCode == 200 &&
            activeResponse.data["error"].toString() == "false") {
          print("got active vendor list");
          final List<dynamic> activeList = activeResponse.data["data"];
          if (activeList.isEmpty) {
            print("No Active Vendor");
          }
          // Keep Data in Modle
          vendorManageModel.keepActiveVendorList(activeList);
        }
      } catch (e) {}
      // Get Inactive Vendor List
      final inactiveUrl = "$mainUrl/inactive/vendor-lists?admin_id=$id";
      final inactiveResponse = await dio.get(
        inactiveUrl,
        options: Options(
          headers: {
            "authorization": "Bearer $token",
          },
          contentType: Headers.jsonContentType,
        ),
      );

      try {
        if (activeResponse.statusCode == 200 &&
            activeResponse.data["error"].toString() == "false") {
          print("got inactive vendor list");
          final List<dynamic> inactiveList = inactiveResponse.data["data"];

          if (inactiveList.isEmpty) {
            print("No Active Vendor");
          }
          // Keep Data in Modle
          vendorManageModel.keepInactiveVendorList(inactiveList);
        }
      } catch (e) {}

      // Get Inactive Vendor List
      final apiAllVendorUrl = "$mainUrl/vendor-lists?admin_id=$id";
      final apiAllVendorResponse = await dio.get(
        apiAllVendorUrl,
        options: Options(
          headers: {
            "authorization": "Bearer $token",
          },
          contentType: Headers.jsonContentType,
        ),
      );

      try {
        if (apiAllVendorResponse.statusCode == 200 &&
            apiAllVendorResponse.data["error"].toString() == "false") {
          print("got all vendor list");
          final List<dynamic> apiAllVendorList =
              apiAllVendorResponse.data["data"];

          if (apiAllVendorList.isEmpty) {
            print("No Active Vendor");
          }
          // Keep Data in Modle
          vendorManageModel.allVendorListAdd(apiAllVendorList);
        }
      } catch (e) {}
    } else {
      print("no api call");
    }
  }

  Future<void> activeToInactiveFunction(
      BuildContext context, String selectedId) async {
    print("active to inactive process");
    // Get Admin id and Token;
    List<String> idTokenList = idAndToken(context);
    id = idTokenList[0];
    token = idTokenList[1];

    final url = "$mainUrl/inactive/vendor/process?admin_id=$id";

    final response = await dio.post(
      url,
      data: {
        "vendor_id": selectedId,
      },
      options: Options(
        headers: {
          "authorization": "Bearer $token",
        },
        contentType: Headers.jsonContentType,
      ),
    );

    print(response);

    try {
      if (response.statusCode == 200 &&
          response.data["error"].toString() == "false") {
        final message = response.data["message"];
        final singUpController = SignUpFormController();
        singUpController.showSnackBar(context, "Success !! ${message} ");
      }
    } catch (e) {}
  }

  Future<void> inactiveToactiveFunction(
      BuildContext context, String selectedId) async {
    // Get Admin id and Token;
    List<String> idTokenList = idAndToken(context);
    id = idTokenList[0];
    token = idTokenList[1];

    final url = "$mainUrl/active/vendor/process?admin_id=$id";

    final response = await dio.post(
      url,
      data: {
        "vendor_id": selectedId,
      },
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
        final message = response.data["message"];
        final singUpController = SignUpFormController();
        singUpController.showSnackBar(context, "Success !! ${message} ");
      }
    } catch (e) {}
  }
}
