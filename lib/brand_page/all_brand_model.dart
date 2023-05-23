import 'package:flutter/material.dart';

class AllBrandModel extends ChangeNotifier {
  Map<String, dynamic> allBrand = {};
  int brandCount = 0;
  List<String> nameList = [];
  List<String> idList = [];
  String? brandName;
  String? brandId;

  void getAllBrand(Map<String, dynamic> input) {
    nameList.clear();
    idList.clear();
    allBrand = input;
    brandCount = allBrand["count"];

    for (var i = 0; i < allBrand["count"]; i++) {
      nameList.add(allBrand["data"][i]["name"].toString());
      idList.add(allBrand["data"][i]["_id"].toString());
    }
    notifyListeners();
  }

  void chooseBrand(String name, String id) {
    brandName = null;
    brandId = null;

    brandName = name;
    brandId = id;

    notifyListeners();
  }
}
