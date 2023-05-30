import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/util/dio.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class GetAllListsController {
  Future<void> getAllList(BuildContext context) async {
    idAndToken(context);
    final allBrandModel = Provider.of<AllBrandData>(context);
    final allCategoryModel = Provider.of<AllCategoryData>(context);
    final allBusinessModel = Provider.of<AllBusinessData>(context);

    List<Response> responses = await Future.wait(
      [
        dio.get(
          "$mainUrl/brands?admin_id=$adminId",
          options: Options(
            headers: {
              "authorization": "Bearer $token",
            },
            contentType: Headers.jsonContentType,
          ),
        ),
        dio.get(
          "$mainUrl/categories?admin_id=$adminId",
          options: Options(
            headers: {
              "authorization": "Bearer $token",
            },
            contentType: Headers.jsonContentType,
          ),
        ),
        dio.get(
          "$mainUrl/businesses?admin_id=$adminId",
          options: Options(
            headers: {
              "authorization": "Bearer $token",
            },
            contentType: Headers.jsonContentType,
          ),
        ),
      ],
    );
    Future.delayed(
      const Duration(seconds: 2),
      () {
        for (var i = 0; i < responses.length; i++) {
          if (i == 0) {
            if (allBrandModel.allBrandList.isEmpty &&
                responses[i].statusCode == 200) {
              keepBrandData(responses[i].data["data"], allBrandModel);
            }
          } else if (i == 1) {
            if (allCategoryModel.allCategoriesList.isEmpty &&
                responses[i].statusCode == 200) {
              keepCategoryData(responses[i].data["data"], allCategoryModel);
            }
          } else if (i == 2) {
            if (allBusinessModel.allBusinessList.isEmpty &&
                responses[i].statusCode == 200) {
              keepBusinessData(responses[i].data["data"], allBusinessModel);
            }
          }
        }
      },
    );
  }

  // Category List
  void keepCategoryData(List<dynamic> responseList, AllCategoryData data) {
    List<AllCategoryModel> list = [];

    // If there is No Data in  Response List
    if (responseList.isEmpty) {
      data.getNoList(); // turn 'isNoData' to true;
    } else {
      for (var i = 0; i < responseList.length; i++) {
        list.add(
          AllCategoryModel(
            categoryId: responseList[i]["_id"].toString(),
            categoryName: responseList[i]["name"].toString(),
            categoryMedia: responseList[i]["media"]["media_link"].toString(),
            mediaId: responseList[i]["media"]["id"].toString(),
            status: responseList[i]["status"].toString(),
          ),
        );
      }

      data.getList(list);
    }
  }

  // Brand List
  void keepBrandData(List<dynamic> responseList, AllBrandData data) {
    List<AllBrandModel> list = [];
    //  If there is No Data in  Response List
    if (responseList.isEmpty) {
      data.getNoList(); // turn 'isNoData' to true;
    } else {
      for (var i = 0; i < responseList.length; i++) {
        list.add(
          AllBrandModel(
            brandId: responseList[i]["_id"].toString(),
            brandName: responseList[i]["name"].toString(),
            brandMedia: responseList[i]["media"]["media_link"].toString(),
            mediaId: responseList[i]["media"]["id"].toString(),
            categoryId: responseList[i]["category_id"].toString(),
          ),
        );
      }
      data.getList(list);
    }
  }

  // Businesses List
  void keepBusinessData(List<dynamic> responseList, AllBusinessData data) {
    List<AllBusinessModel> list = [];

    // If there is No Data in  Response List
    if (responseList.isEmpty) {
      data.getNoList(); // turn 'isNoData' to true;
    } else {
      for (var i = 0; i < responseList.length; i++) {
        list.add(
          AllBusinessModel(
            name: responseList[i]["name"].toString(),
            address: responseList[i]["address"].toString(),
            businessId: responseList[i]["_id"].toString(),
            mediaId: responseList[i]["media"]["id"].toString(),
            mediaUrl: responseList[i]["media"]["media_link"].toString(),
            category: responseList[i]["category"],
            brand: responseList[i]["category"],
          ),
        );
      }
      data.getList(list);
    }
  }
}
