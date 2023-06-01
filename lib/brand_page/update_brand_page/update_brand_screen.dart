import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/update_brand_page/update_brand_controller.dart';
import 'package:vendor_admin/brand_page/update_brand_page/update_brand_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/custom_config/util/image_base64.dart';

class UpdateBrandScreen extends StatefulWidget {
  final String name;
  final String brandId;
  final String url;
  final String categoryId;
  final String categoryName;
  const UpdateBrandScreen({
    super.key,
    required this.name,
    required this.brandId,
    required this.url,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<UpdateBrandScreen> createState() => _UpdateBrandScreenState();
}

class _UpdateBrandScreenState extends State<UpdateBrandScreen> {
  final controller = UpdateBrandController();
  bool isApiWaiting = false;
  bool isNothingChange = false;
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.categoryId;
    controller.brandName = TextEditingController(text: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final model = Provider.of<UpdateBrandModel>(context);

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
            child: Consumer2<UpdateBrandModel, AllCategoryData>(
                builder: (context, model, allCategoryData, _) {
              return Container(
                width: screenWidth,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const MainTitle(
                      titleName: "Update Brand",
                    ),
                    const SizedBoxHeight(height: 30),
                    // Choose Category

                    DropdownButton<String>(
                      value: selectedCategoryId,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategoryId = newValue;
                        });
                      },
                      items: allCategoryData.allCategoriesList
                          .map((AllCategoryModel categoryModel) {
                        return DropdownMenuItem<String>(
                          value: categoryModel.categoryId,
                          child: Text(categoryModel.categoryName),
                        );
                      }).toList(),
                    ),

                    // Name Form Field
                    Form(
                      key: controller.formKey,
                      child: NameInputBox(
                        validation: (value) {
                          return controller.validateCategoryName(value);
                        },
                        textEditingController: controller.brandName,
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
                          if (controller.brandName.text == widget.name &&
                              model.choosedImage == null &&
                              selectedCategoryId == null) {
                            setState(
                              () {
                                isNothingChange = true;
                              },
                            );
                          } else {
                            print("click");
                            setState(() {
                              isApiWaiting = true;
                            });
                            controller
                                .updateBrand(
                                    context, widget.brandId, selectedCategoryId)
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
              );
            }),
          ),
        ),
      ),
    );
  }
}
