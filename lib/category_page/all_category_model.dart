import 'package:flutter/material.dart';

class AllCategoryModel {
  final String categoryId;
  final String categoryName;
  final String categoryMedia;
  final String mediaId;
  final String status;

  AllCategoryModel({
    required this.categoryId,
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

  // Adding New Category
  void addNewCategory(AllCategoryModel data) {
    allCategoriesList.insert(0, data);
    notifyListeners();
  }

  // Updating New Category Data
  void editCategory(String id, AllCategoryModel updateCategoryData) {
    int index =
        allCategoriesList.indexWhere((element) => element.categoryId == id);
    allCategoriesList[index] = updateCategoryData;

    notifyListeners();
  }

  // Deleting Category
  void deleteCategory(String id) {
    allCategoriesList.removeWhere(
      (element) => element.categoryId == id,
    );
    notifyListeners();
  }
}
