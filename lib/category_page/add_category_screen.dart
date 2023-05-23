import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/category_page/add_category_controller.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final controller = AddCategoryController();
  @override
  Widget build(BuildContext context) {
    final brandIdAndName = Provider.of<AllBrandModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      child: Column(
        children: [
          const MainTitle(
            titleName: "Adding New Category",
          ),
          SizedBoxHeight(height: 30),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: color.secondaryColor,
              borderRadius: BorderRadius.circular(
                5,
              ),
              border: Border.all(
                width: 1.5,
                color: color.black,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Adding Category of ",
                  style: TextStyle(
                    color: color.primaryColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBoxHeight(height: 10),
                Text(
                  "${brandIdAndName.brandName}",
                  style: TextStyle(
                    color: color.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          NameInputBox(
            validation: (value) {
              return controller.validateCategoryName(value);
            },
            formKey: controller.formKey,
            textEditingController: controller.categoryName,
            boxTitle: "Category Name :",
          ),
        ],
      ),
    );
  }
}
