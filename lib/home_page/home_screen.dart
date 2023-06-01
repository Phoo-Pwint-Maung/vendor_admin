import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<AllBrandData, AllCategoryData, AllBusinessData>(
        builder: (context, brand, category, business, _) {
      return Container(
        child: Column(
          children: [
            Text("Brand List is : ${brand.allBrandList.length}"),
            Text("Category List is : ${category.allCategoriesList.length}"),
            Text("Business List is : ${business.allBusinessList.length}"),
          ],
        ),
      );
    });
  }
}
