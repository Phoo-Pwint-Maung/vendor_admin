import 'package:flutter/material.dart';

class AllBusinessModel {
  final String name;
  final String address;
  final String businessId;
  final String mediaId;
  final String mediaUrl;
  final List category;
  final List brand;

  AllBusinessModel({
    required this.name,
    required this.address,
    required this.businessId,
    required this.mediaId,
    required this.mediaUrl,
    required this.brand,
    required this.category,
  });
}

class AllBusinessData extends ChangeNotifier {
  List<AllBusinessModel> allBusinessList = [];

  bool isNoData = false;
  // Getting All Categories List
  void getList(List<AllBusinessModel> list) {
    isNoData = false;

    allBusinessList = list;

    notifyListeners();
  }

  // But There is No Business in Api
  void getNoList() {
    isNoData = true;
    notifyListeners();
  }

  void deleteBusiness(String id) {
    allBusinessList.removeWhere((element) => element.businessId == id);
    notifyListeners();
  }

  void editBusiness(String id, AllBusinessModel model) {
    List<AllBusinessModel> selectedItem =
        allBusinessList.where((element) => element.businessId == id).toList();
    if (selectedItem.isNotEmpty) {
      int index = allBusinessList.indexOf(selectedItem.first);
      allBusinessList[index] = model;
    }

    notifyListeners();
  }
}
