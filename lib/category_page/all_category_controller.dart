import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';

import 'package:vendor_admin/custom_config/util/getListsController.dart';

class AllCategoryController {
  final scroll = ScrollController();
  final getListsController = GetListsController();

  Future<void> getAllCategoryList(BuildContext context) async {
    // All Category Model
    final model = Provider.of<AllCategoryData>(context, listen: false);

    if (model.allCategoriesList.isEmpty) {
      // Get Categories List From Api
      await getListsController.getCategoryList(
        context: context,
        categoryModel: model,
      );
    }
  }
}
