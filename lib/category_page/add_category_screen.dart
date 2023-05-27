import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/category_page/add_category_controller.dart';
import 'package:vendor_admin/category_page/add_category_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/custom_config/util/image_base64.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final controller = AddCategoryController();
  bool imageRequired = false;
  bool isApiWaiting = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final model = Provider.of<AddCategoryModel>(context);

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
          SizedBoxHeight(height: 30),
          // showing Image row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  showPreviewImage(context, model.choosedImage),
                  if (imageRequired)
                    Text(
                      "* Image is required *",
                      style: TextStyle(
                        color: color.secondaryColor,
                      ),
                    ),
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: isApiWaiting
                      ? MaterialStateProperty.all<Color>(
                          color.grey,
                        )
                      : MaterialStateProperty.all<Color>(
                          color.secondaryColor,
                        ),
                ),
                onPressed: () {
                  model.chooseAndKeepImage().whenComplete(() {
                    if (model.isImageChoosed) {
                      setState(() {
                        imageRequired = false;
                      });
                    }
                  });
                },
                child: Text(
                  "Choose Image",
                  style: TextStyle(
                    color: color.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBoxHeight(height: 30),
          // Comfirm Button
          SizedBox(
            width: screenWidth * 0.8,
            child: ElevatedButton(
              onPressed: () {
                if (!model.isImageChoosed) {
                  setState(() {
                    imageRequired = true; // to show image is required
                  });
                }
                if (controller.formKey.currentState!.validate() &&
                    model.isImageChoosed) {
                  setState(() {
                    isApiWaiting = true;
                  });
                  controller.createCategory(context).whenComplete(() {
                    setState(() {
                      isApiWaiting = false;
                    });
                  });
                }
              },
              child: Text("Add"),
              style: ButtonStyle(
                backgroundColor: isApiWaiting
                    ? MaterialStateProperty.all<Color>(
                        color.grey,
                      )
                    : MaterialStateProperty.all<Color>(
                        color.secondaryColor,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
