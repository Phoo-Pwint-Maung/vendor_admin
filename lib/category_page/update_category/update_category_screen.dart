import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/category_page/update_category/update_category_controller.dart';
import 'package:vendor_admin/category_page/update_category/update_category_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/custom_config/util/image_base64.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final String name;
  final String url;
  final String categoryId;
  const UpdateCategoryScreen({
    super.key,
    required this.name,
    required this.url,
    required this.categoryId,
  });

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final controller = UpdateCategoryController();
  bool isApiWaiting = false;
  bool isNothingChange = false;

  @override
  void initState() {
    super.initState();
    controller.categoryName = TextEditingController(text: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final model = Provider.of<UpdateCategoryModel>(context);
    return WillPopScope(
      onWillPop: () async {
        model.choosedImage = null;
        model.imageStr = null;

        Navigator.pop(context);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: color.ternaryColor,
          appBar: AppBar(
            backgroundColor: color.secondaryColor,
            leading: GestureDetector(
              onTap: () {
                model.choosedImage = null;
                model.imageStr = null;

                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_sharp,
              ),
            ),
          ),
          body: SingleChildScrollView(
            controller: controller.scroll,
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Column(
                children: [
                  const MainTitle(
                    titleName: "Update Category",
                  ),
                  const SizedBoxHeight(height: 30),
                  // Name Form Field
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
                  const SizedBoxHeight(height: 30),
                  // Image Choosed Here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          updatePageImage(
                            model.choosedImage,
                            widget.url,
                            context,
                          )
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
                            if (model.choosedImage != null) {
                              isNothingChange = false;
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
                  const SizedBoxHeight(height: 30),
                  // Comfirm Button
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        // Update Function Process
                        if (controller.categoryName.text == widget.name &&
                            model.choosedImage == null) {
                          setState(
                            () {
                              isNothingChange = true;
                            },
                          );
                        } else {
                          setState(() {
                            isApiWaiting = true;
                          });
                          controller
                              .updateCategory(context, widget.categoryId)
                              .whenComplete(() {
                            model.choosedImage = null;
                            model.imageStr = null;
                            Navigator.pop(context);
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: isApiWaiting
                            ? MaterialStateProperty.all<Color>(
                                color.grey,
                              )
                            : MaterialStateProperty.all<Color>(
                                color.secondaryColor,
                              ),
                      ),
                      child: const Text("Update"),
                    ),
                  ),
                  if (isNothingChange)
                    Text(
                      "** Please Change Something To Update!",
                      style: TextStyle(
                        color: color.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
