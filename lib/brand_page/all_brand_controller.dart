import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllBrandController {
  final dio = Dio();
  final scroll = ScrollController();

  // String categoryName(BuildContext context, int index) {
  //   final allBrandModel = Provider.of<AllBrandData>(context, listen: false);
  //   final allCategoryModel =
  //       Provider.of<AllCategoryData>(context, listen: false);
  //   final List<AllCategoryModel> selectedItem =
  //       allCategoryModel.allCategoriesList.where(
  //     (element) {
  //       return element.categoryId ==
  //           allBrandModel.allBrandList[index].categoryId;
  //     },
  //   ).toList();

  //   return selectedItem.first.categoryName.toString();
  // }
}
