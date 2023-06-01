import 'package:flutter/material.dart';

class VendorModel {
  String vendorId;
  String name;
  String shopName;
  String email;
  String phone;
  String joinDate;
  String address;
  String profileUrl;
  String status;

  VendorModel({
    required this.vendorId,
    required this.name,
    required this.shopName,
    required this.email,
    required this.phone,
    required this.joinDate,
    required this.address,
    required this.profileUrl,
    required this.status,
  });
}

class VendorManageModel extends ChangeNotifier {
  List<VendorModel> activeVendorList = [];
  List<VendorModel> inactiveVendorList = [];
  List<VendorModel> allVendorList = [];
  List<VendorModel> apiAllVendorList = [];
  void keepActiveVendorList(List<dynamic> list) {
    if (list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        activeVendorList.add(
          VendorModel(
            vendorId: list[i]["_id"].toString(),
            name: list[i]["name"].toString(),
            shopName: list[i]["shop_name"].toString(),
            email: list[i]["email"].toString(),
            phone: list[i]["phone"].toString(),
            joinDate: list[i]["join_date"].toString(),
            address: list[i]["address"].toString(),
            profileUrl: list[i]["profile"].toString(),
            status: list[i]["status"].toString(),
          ),
        );
      }
    }
    notifyListeners();
  }

  void keepInactiveVendorList(List<dynamic> list) {
    if (list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        inactiveVendorList.add(
          VendorModel(
            vendorId: list[i]["_id"].toString(),
            name: list[i]["name"].toString(),
            shopName: list[i]["shop_name"].toString(),
            email: list[i]["email"].toString(),
            phone: list[i]["phone"].toString(),
            joinDate: list[i]["join_date"].toString(),
            address: list[i]["address"].toString(),
            profileUrl: list[i]["profile"].toString(),
            status: list[i]["status"].toString(),
          ),
        );
      }
    }
    notifyListeners();
  }

  void allVendorListAdd(List<dynamic> allList) {
    if (activeVendorList.isNotEmpty || inactiveVendorList.isNotEmpty) {
      allVendorList = activeVendorList + inactiveVendorList;
    }
    for (var i = 0; i < allList.length; i++) {
      Iterable<VendorModel> getVendor = allVendorList.where((element) {
        return element.vendorId == allList[i]["_id"].toString();
      });
      apiAllVendorList.add(getVendor.first);
    }

    notifyListeners();
  }

  void inactiveToActive(String id) {
    final selectedVendor = apiAllVendorList.where(
      (element) {
        return element.vendorId == id;
      },
    );
    selectedVendor.first.status = "1";
    inactiveVendorList.removeWhere(
      (element) {
        return element.vendorId == id;
      },
    );
    activeVendorList.add(selectedVendor.first);
    notifyListeners();
  }

  void activeToInactive(String id) {
    final selectedVendor = apiAllVendorList.where(
      (element) {
        return element.vendorId == id;
      },
    );
    selectedVendor.first.status = "0";
    activeVendorList.removeWhere(
      (element) {
        return element.vendorId == id;
      },
    );
    inactiveVendorList.add(selectedVendor.first);
    notifyListeners();
  }
}
