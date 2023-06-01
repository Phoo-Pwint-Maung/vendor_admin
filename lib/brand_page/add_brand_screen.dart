import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/add_brand_controller.dart';
import 'package:vendor_admin/brand_page/add_brand_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';
import 'package:vendor_admin/custom_config/util/image_base64.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';
import 'package:vendor_admin/profile_setting/profile_setting_component.dart';

class AddBrandScreen extends StatefulWidget {
  const AddBrandScreen({super.key});

  @override
  State<AddBrandScreen> createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  final color = ColorConst();
  final controller = AddBrandController();
  bool isClickedAdd = false;
  bool isApiLoading = false;
  bool isSelectCategory = false;

  String? selectedCategoryId;

  late List<AllCategoryModel> options;
  List<AllCategoryModel> selectedCategory = [];

  @override
  Widget build(BuildContext context) {
    // width
    double screenWidth = MediaQuery.of(context).size.width;

    return Consumer3<AddBrandModel, AllCategoryData, NavBarModel>(
        builder: (context, model, allCategoryModel, navBarModel, _) {
      return SingleChildScrollView(
        controller: controller.scroll,
        child: Container(
          width: screenWidth,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const MainTitle(titleName: "Adding New Brand"),
                const SizedBoxHeight(height: 30),
                // Choose Category

                ElevatedButton(
                  onPressed: () {
                    showBottomSheet(
                        context: context,
                        builder: (context) {
                          return MultiSelectBottomSheet(
                            items: allCategoryModel.allCategoriesList
                                .map((e) => MultiSelectItem(e, e.categoryName))
                                .toList(),
                            initialValue: allCategoryModel.allCategoriesList,
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
                // Brand Name Form Field
                Form(
                  key: controller.formKey,
                  child: NameInputBox(
                    validation: (value) {
                      return controller.validateBrandName(value);
                    },
                    textEditingController: controller.brandName,
                    boxTitle: "Name :",
                  ),
                ),
                const SizedBoxHeight(height: 30),

                // Image choosing row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        showPreviewImage(
                          context,
                          model.choosedImage,
                        ),
                        if (model.choosedImage == null && isClickedAdd == true)
                          Text('Please Choose Image')
                      ],
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: isApiLoading
                            ? MaterialStateProperty.all<Color>(
                                color.grey,
                              )
                            : MaterialStateProperty.all<Color>(
                                color.secondaryColor,
                              ),
                      ),
                      onPressed: () {
                        model.chooseImageFun();
                      },
                      child: Text(
                        "Choose Image",
                        style: TextStyle(
                          color:
                              isApiLoading ? color.black : color.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBoxHeight(height: 80),
                ProfileSettingBtn(
                  btnName: "Add",
                  btnFunction: isApiLoading
                      ? null
                      : () {
                          setState(() {
                            isClickedAdd = true;
                          });
                          if (controller.formKey.currentState!.validate() &&
                              model.choosedImage != null &&
                              selectedCategoryId != null) {
                            setState(() {
                              isApiLoading = true;
                            });
                            controller
                                .addBrand(context, selectedCategoryId!)
                                .whenComplete(() {
                              setState(() {
                                isApiLoading = false;
                              });
                              navBarModel.changePage(DrawerSection.allBrand);
                            });
                          }
                        },
                  btnColor: isApiLoading
                      ? MaterialStateProperty.all<Color>(
                          color.grey,
                        )
                      : MaterialStateProperty.all<Color>(
                          color.secondaryColor,
                        ),
                ),
                if (isClickedAdd == true && selectedCategoryId == null)
                  Text("* Select Category *"),
              ],
            ),
          ),
        ),
      );
    });
  }
}
