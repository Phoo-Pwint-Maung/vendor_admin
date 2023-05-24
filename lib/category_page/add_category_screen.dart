import 'package:flutter/material.dart';
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
          const SizedBoxHeight(height: 30),
          Form(
            key: controller.formKey,
            child: NameInputBox(
              validation: (value) {
                return controller.validateCategoryName(value);
              },
              textEditingController: controller.categoryName,
              boxTitle: "Name :",
            ),
          ),
        ],
      ),
    );
  }
}
