import 'package:flutter/material.dart';

class AllBrandModel {
  final String brandId;
  final String brandName;
  final String brandMedia;
  final String mediaId;
  final String categoryId;

  AllBrandModel({
    required this.brandId,
    required this.brandName,
    required this.brandMedia,
    required this.mediaId,
    required this.categoryId,
  });
}

class AllBrandData extends ChangeNotifier {
  List<AllBrandModel> allBrandList = [];

  bool isNoData = false;
  // Getting All Categories List
  void getList(List<AllBrandModel> list) {
    allBrandList = list;
    print("brand model keeping...");
    print(allBrandList);

    notifyListeners();
  }

  // But There is No Category in Api
  void getNoList() {
    isNoData = true;
    notifyListeners();
  }

  // Adding New Category
  void addNewBrand(AllBrandModel data) {
    allBrandList.insert(0, data);
    notifyListeners();
  }
}
