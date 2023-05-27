import 'package:flutter/material.dart';

class AllCategoryModel {
  final String catergoryId;
  final String categoryName;
  final String categoryMedia;
  final String mediaId;
  final String status;

  AllCategoryModel({
    required this.catergoryId,
    required this.categoryName,
    required this.categoryMedia,
    required this.mediaId,
    required this.status,
  });
}

class AllCategoryData extends ChangeNotifier {
  List<AllCategoryModel> allCategoriesList = [];

  bool isNoData = false;
  // Getting All Categories List
  void getList(List<AllCategoryModel> list) {
    isNoData = false;

    allCategoriesList = list;

    notifyListeners();
  }

  // But There is No Category in Api
  void getNoList() {
    isNoData = true;
    notifyListeners();
  }

  void addNewCategory(AllCategoryModel data) {
    allCategoriesList.insert(0, data);
    notifyListeners();
  }
}
