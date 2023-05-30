import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/util/getListsController.dart';

class AllBrandController {
  final dio = Dio();
  final scroll = ScrollController();
  final getAllListsController = GetListsController();

  Future<void> getAllBrand(BuildContext context) async {
    final allBrandModel = Provider.of<AllBrandData>(context, listen: false);
    final allCategoryModel =
        Provider.of<AllCategoryData>(context, listen: false);
    print("here");
    if (allCategoryModel.allCategoriesList.isEmpty) {
      print("here1");
      await getAllListsController.getCategoryList(
        context: context,
        categoryModel: allCategoryModel,
      );
    }
    print("herer 2");
    if (allBrandModel.allBrandList.isEmpty) {
      print("herer 2 is empty");
      await getAllListsController.getBrandList(
        context: context,
        brandModel: allBrandModel,
      );
    }
    print("end");
  }

  String categoryName(BuildContext context, int index) {
    final allBrandModel = Provider.of<AllBrandData>(context, listen: false);
    final allCategoryModel =
        Provider.of<AllCategoryData>(context, listen: false);
    final List<AllCategoryModel> selectedItem =
        allCategoryModel.allCategoriesList.where(
      (element) {
        return element.categoryId ==
            allBrandModel.allBrandList[index].categoryId;
      },
    ).toList();

    return selectedItem.first.categoryName.toString();
  }
}
