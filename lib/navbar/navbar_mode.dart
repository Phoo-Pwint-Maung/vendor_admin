import 'package:flutter/material.dart';

class NavBarModel extends ChangeNotifier {
  var currentPage = DrawerSection.home;
  void changePage(DrawerSection page) {
    currentPage = page;
    notifyListeners();
  }
}

enum DrawerSection {
  home,
  allBrand,
  addBrand,
}
