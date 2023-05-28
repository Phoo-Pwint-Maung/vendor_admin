import 'package:flutter/material.dart';

class AllBrandModel {
  final String brandId;
  final String brandName;
  final String brandMedia;
  final String mediaId;
  final String categoryId;
  final String categoryName;

  AllBrandModel({
    required this.brandId,
    required this.brandName,
    required this.brandMedia,
    required this.mediaId,
    required this.categoryId,
    required this.categoryName,
  });
}

class AllBrandData extends ChangeNotifier {
  List<dynamic> allBrandList = [];
  List<String> brandNameList = [];

  void getAllBrandData(List<dynamic> list) {
    if (allBrandList.isEmpty) {
      allBrandList = list;
      if (allBrandList.isNotEmpty && brandNameList.isEmpty) {
        for (var i = 0; i < allBrandList.length; i++) {
          brandNameList.add(allBrandList[i]["name"]);
        }
      }
    }
    notifyListeners();
  }
}
