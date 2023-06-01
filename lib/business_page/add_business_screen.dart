import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/business_page/add_business_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/business_page/add_business_controller.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/custom_config/util/image_base64.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  final controller = AddBusinessController();
  List<AllCategoryModel> selectedCategory = [];
  bool isSelectCategory = false;
  List<AllBrandModel> selectedBrand = [];
  bool isSelectBrand = false;
  bool isApiCallInProgress = false; // Flag to track API call status
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer4<AddBusinessModel, NavBarModel, AllCategoryData,
            AllBrandData>(
        builder:
            (context, model, navBarModel, allCategoryModel, allBrandModel, _) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        width: screenWidth,
        child: Column(
          children: [
            const MainTitle(titleName: "Adding New Business"),
            const SizedBoxHeight(
              height: 30,
            ),
            Form(
              key: controller.formKey,
              child: SizedBox(
                width: screenWidth * 0.9,
                child: Column(
                  children: [
                    NameInputBox(
                      validation: (value) {
                        return controller.validateTextFormField(value);
                      },
                      textEditingController: controller.businessName,
                      boxTitle: "Name : ",
                    ),
                    const SizedBoxHeight(height: 30),
                    NameInputBox(
                      validation: (value) {
                        return controller.validateTextFormField(value);
                      },
                      textEditingController: controller.businessAddress,
                      boxTitle: "Address : ",
                    ),
                    SizedBoxHeight(
                      height: 30,
                    ),
                    // Category Select

                    ElevatedButton(
                      onPressed: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return MultiSelectBottomSheet(
                                items: allCategoryModel.allCategoriesList
                                    .map((e) =>
                                        MultiSelectItem(e, e.categoryName))
                                    .toList(),
                                initialValue:
                                    allCategoryModel.allCategoriesList,
                                onConfirm: (List<AllCategoryModel> result) {
                                  setState(() {
                                    selectedCategory = result;
                                    isSelectCategory = true;
                                  });
                                },
                              );
                            });
                      },
                      child: Text("Select Category"),
                    ),
                    if (isSelectCategory)
                      Container(
                        width: screenWidth * 0.9,
                        height: 30,
                        decoration: BoxDecoration(
                          color: color.secondaryColor,
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          controller: ScrollController(),
                          itemCount: selectedCategory.length,
                          itemBuilder: (context, index) {
                            return index == (selectedCategory.length - 1)
                                ? Text(
                                    "${selectedCategory[index].categoryName}.",
                                    style: TextStyle(
                                      color: color.white,
                                    ),
                                  )
                                : Text(
                                    "${selectedCategory[index].categoryName} ,",
                                    style: TextStyle(
                                      color: color.white,
                                    ),
                                  );
                          },
                        ),
                      ),
                    // Brand Select

                    ElevatedButton(
                      onPressed: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return MultiSelectBottomSheet(
                                  items: allBrandModel.allBrandList
                                      .map((e) =>
                                          MultiSelectItem(e, e.brandName))
                                      .toList(),
                                  initialValue: allBrandModel.allBrandList,
                                  onConfirm: (List<AllBrandModel> result) {
                                    setState(() {
                                      selectedBrand = result;
                                      isSelectBrand = true;
                                    });
                                  });
                            });
                      },
                      child: Text("Select Brand"),
                    ),
                    if (isSelectBrand)
                      Container(
                        width: screenWidth * 0.9,
                        height: 30,
                        decoration: BoxDecoration(
                          color: color.secondaryColor,
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          controller: ScrollController(),
                          itemCount: selectedBrand.length,
                          itemBuilder: (context, index) {
                            return index == (selectedBrand.length - 1)
                                ? Text(
                                    "${selectedBrand[index].brandName}.",
                                    style: TextStyle(
                                      color: color.white,
                                    ),
                                  )
                                : Text(
                                    "${selectedBrand[index].brandName} ,",
                                    style: TextStyle(
                                      color: color.white,
                                    ),
                                  );
                          },
                        ),
                      ),

                    // showing Image row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            showPreviewImage(context, model.choosedImage)
                          ],
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              color.secondaryColor,
                            ),
                          ),
                          onPressed: () {
                            model.chooseAndKeepImage();
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
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: isApiCallInProgress
                  ? null
                  : () {
                      if (controller.formKey.currentState!.validate() &&
                          model.choosedImage != null &&
                          isSelectBrand &&
                          isSelectCategory) {
                        setState(() {
                          isApiCallInProgress = true; // Set the flag to true
                        });

                        controller
                            .addNewBusiness(
                                context, selectedCategory, selectedBrand)
                            .then((_) {
                          navBarModel.changePage(DrawerSection.allBusiness);
                        }).catchError((error) {
                          print('API Error: $error');
                        }).whenComplete(() {
                          setState(() {
                            isApiCallInProgress =
                                false; // Set the flag back to false
                          });
                        });
                      }
                    },
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    });
  }
}
