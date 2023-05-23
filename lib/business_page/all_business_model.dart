import 'package:flutter/material.dart';

class AllBusinessModel extends ChangeNotifier {
  int? allBusinessCount;
  List<dynamic> allBusinessList = [];

  void allBusinessData(int count, List<dynamic> list) {
    allBusinessCount = count;
    allBusinessList = list;

    notifyListeners();
  }
}
