import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/category_page/all_category_card.dart';
import 'package:vendor_admin/category_page/all_category_controller.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  final controller = AllCategoryController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer2<AllCategoryData, NavBarModel>(
        builder: (context, model, navBarModel, _) {
      return SingleChildScrollView(
        controller: controller.scroll,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          width: screenWidth,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Category :  ' ${model.allCategoriesList.length} '",
                      style: TextStyle(
                        color: color.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: color.secondaryColor,
                        ),
                      ),
                      onPressed: () {
                        navBarModel.changePage(DrawerSection.addCategory);
                      },
                      child: Text(
                        "Add +",
                        style: TextStyle(
                          fontSize: 18,
                          color: color.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBoxHeight(
                height: 30,
              ),

              // Show List

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    (model.allCategoriesList.length / 2) //brandList.brandCount
                        .ceil(), // Determine the number of rows needed
                itemBuilder: (context, rowIndex) {
                  return GridView.count(
                    crossAxisCount: 2, // Number of cards per row
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.87,

                    children: model.allCategoriesList
                        .skip(rowIndex * 2)
                        .take(2)
                        .map((item) {
                      return GestureDetector(
                        onTap: () {},
                        // Showing Brand Cards
                        child: AllCategoryCard(
                          name: item.categoryName,
                          url: item.categoryMedia,
                          categoryId: item.categoryId,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
