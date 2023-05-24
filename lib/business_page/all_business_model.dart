import 'package:flutter/material.dart';

class AllBusinessModel extends ChangeNotifier {
  List<dynamic> allBusinessList = [];
  List<String> businessNameList = [];
  List<String> businessAddressList = [];
  List<String> businessIdList = [];
  List<String> businessMediaId = [];
  List<String> businessMediaUrl = [];

  void allBusinessData(List<dynamic> list) {
    if (allBusinessList.isEmpty) {
      allBusinessList = list;

      if (allBusinessList.isNotEmpty && businessNameList.isEmpty) {
        for (var i = 0; i < allBusinessList.length; i++) {
          businessNameList.add(allBusinessList[i]["name"]);
          businessAddressList.add(allBusinessList[i]["address"]);
          businessIdList.add(allBusinessList[i]["_id"]);
          businessMediaUrl.add(allBusinessList[i]["media"]["media_link"]);
          businessMediaUrl.add(allBusinessList[i]["media"]["id"]);
        }
      }
    } else {
      return;
    }

    notifyListeners();
  }
}
