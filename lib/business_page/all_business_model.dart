import 'package:flutter/material.dart';

class AllBusinessModel {
  final String name;
  final String address;
  final String businessId;
  final String mediaId;
  final String mediaUrl;

  AllBusinessModel({
    required this.name,
    required this.address,
    required this.businessId,
    required this.mediaId,
    required this.mediaUrl,
  });
}

class AllBusinessData extends ChangeNotifier {
  List<dynamic> allBusinessList = [];

  List<AllBusinessModel> allList = [];

  void allBusinessData(List<dynamic> list) {
    if (allBusinessList.isEmpty) {
      allBusinessList = list;

      if (allBusinessList.isNotEmpty) {
        for (var i = 0; i < allBusinessList.length; i++) {
          allList.add(
            AllBusinessModel(
              name: allBusinessList[i]["name"],
              address: allBusinessList[i]["address"],
              businessId: allBusinessList[i]["_id"],
              mediaId: allBusinessList[i]["media"]["id"],
              mediaUrl: allBusinessList[i]["media"]["media_link"],
            ),
          );
        }
      }
    } else {
      return;
    }

    notifyListeners();
  }

  void deleteBusiness(String id) {
    allList.removeWhere((element) => element.businessId == id);
    notifyListeners();
  }

  void editBusiness(String id, AllBusinessModel model) {
    List<AllBusinessModel> selectedItem =
        allList.where((element) => element.businessId == id).toList();
    if (selectedItem.isNotEmpty) {
      int index = allList.indexOf(selectedItem.first);
      allList[index] = model;
    }

    notifyListeners();
  }
}
