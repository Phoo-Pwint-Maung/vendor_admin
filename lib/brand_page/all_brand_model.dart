import 'package:flutter/material.dart';

class AllBrandModel extends ChangeNotifier {
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
