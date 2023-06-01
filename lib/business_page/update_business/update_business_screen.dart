import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/business_page/update_business/update_business_controller.dart';
import 'package:vendor_admin/business_page/update_business/update_business_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/custom_config/util/image_base64.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';

class UpdateBusinessScreen extends StatefulWidget {
  final String id;

  const UpdateBusinessScreen({super.key, required this.id});

  @override
  State<UpdateBusinessScreen> createState() => _UpdateBusinessScreenState();
}

class _UpdateBusinessScreenState extends State<UpdateBusinessScreen> {
  final updateController = UpdateBusinessController();
  List<AllCategoryModel> selectedCategory = [];
  List<AllBrandModel> selectedBrand = [];
  bool isSelectedCategory = false;
  bool isSelectedBrand = false;

  int selectedItemIndex = 0;

  bool isApiCallInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      selectedItemIndex =
          updateController.selectedBusinessData(context, widget.id);
    });
  }

  // Flag to track API call status
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: color.ternaryColor,
      appBar: AppBar(
        backgroundColor: color.secondaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: updateController.scroll,
        child: Consumer5<UpdateBusinessModel, NavBarModel, AllBusinessData,
                AllCategoryData, AllBrandData>(
            builder: (context, model, navBarModel, allBusinessModel,
                allCategoryModel, allBrandModel, _) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            width: screenWidth,
            child: Column(
              children: [
                MainTitle(
                    titleName:
                        "Update ' ${allBusinessModel.allBusinessList[selectedItemIndex].name} ' "),
                const SizedBoxHeight(
                  height: 30,
                ),
                Form(
                  key: updateController.formKey,
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    child: Column(
                      children: [
                        NameInputBox(
                          validation: (value) {
                            return updateController
                                .validateTextFormField(value);
                          },
                          textEditingController: updateController.businessName,
                          boxTitle: "Name : ",
                        ),
                        const SizedBoxHeight(height: 30),
                        NameInputBox(
                          validation: (value) {
                            return updateController
                                .validateTextFormField(value);
                          },
                          textEditingController:
                              updateController.businessAddress,
                          boxTitle: "Address : ",
                        ),
                        const SizedBoxHeight(
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
                                        isSelectedCategory = true;
                                      });
                                    },
                                  );
                                });
                          },
                          child: Text("Select Category"),
                        ),

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
                            itemCount: isSelectedCategory
                                ? selectedCategory.length
                                : allBusinessModel
                                    .allBusinessList[selectedItemIndex]
                                    .category
                                    .length,
                            itemBuilder: (context, index) {
                              return isSelectedCategory
                                  ? index == (selectedCategory.length - 1)
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
                                        )
                                  : index ==
                                          (allBusinessModel
                                                  .allBusinessList[
                                                      selectedItemIndex]
                                                  .category
                                                  .length -
                                              1)
                                      ? Text(
                                          "${allBusinessModel.allBusinessList[selectedItemIndex].category[index]["name"]}.",
                                          style: TextStyle(
                                            color: color.white,
                                          ),
                                        )
                                      : Text(
                                          "${allBusinessModel.allBusinessList[selectedItemIndex].category[index]["name"]} ,",
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
                                          isSelectedBrand = true;
                                        });
                                      });
                                });
                          },
                          child: Text("Select Brand"),
                        ),

                        Container(
                          width: screenWidth * 0.9,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color.secondaryColor,
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            controller: ScrollController(),
                            itemCount: isSelectedBrand
                                ? selectedBrand.length
                                : allBusinessModel
                                    .allBusinessList[selectedItemIndex]
                                    .brand
                                    .length,
                            itemBuilder: (context, index) {
                              return isSelectedBrand
                                  ? index == (selectedBrand.length - 1)
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
                                        )
                                  : index ==
                                          (allBusinessModel
                                                  .allBusinessList[
                                                      selectedItemIndex]
                                                  .brand
                                                  .length -
                                              1)
                                      ? Text(
                                          "${allBusinessModel.allBusinessList[selectedItemIndex].brand[index]["name"]}.",
                                          style: TextStyle(
                                            color: color.white,
                                          ),
                                        )
                                      : Text(
                                          "${allBusinessModel.allBusinessList[selectedItemIndex].brand[index]["name"]} ,",
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
                                showPreviewImageUpdate(
                                  context,
                                  model,
                                  model.choosedImage,
                                  allBusinessModel
                                      .allBusinessList[selectedItemIndex]
                                      .mediaUrl,
                                  model.isSelectImage,
                                )
                              ],
                            ),
                            ElevatedButton(
                              style: isApiCallInProgress
                                  ? ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                      color.grey,
                                    ))
                                  : ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        color.secondaryColor,
                                      ),
                                    ),
                              onPressed: () {
                                model.chooseAndKeepImage();
                              },
                              child: Text(
                                "Choose Image",
                                style: TextStyle(
                                  color: isApiCallInProgress
                                      ? Colors.black54
                                      : color.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBoxHeight(
                  height: 30,
                ),
                ElevatedButton(
                  style: isApiCallInProgress
                      ? ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                          color.grey,
                        ))
                      : ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            color.primaryColor,
                          ),
                        ),
                  onPressed: isApiCallInProgress
                      ? null
                      : () {
                          setState(() {
                            isApiCallInProgress = true; // Set the flag to true
                          });
                          if (updateController.formKey.currentState!
                              .validate()) {
                            updateController
                                .updateBusiness(
                              context,
                              widget.id,
                              selectedCategory,
                              selectedBrand,
                            )
                                .catchError((error) {
                              print('API Error: $error');
                            }).whenComplete(() {
                              setState(() {
                                isApiCallInProgress =
                                    false; // Set the flag back to false
                              });
                            });
                          }
                        },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16,
                      color: isApiCallInProgress ? Colors.black54 : color.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
