import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/add_brand_controller.dart';
import 'package:vendor_admin/brand_page/add_brand_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';
import 'package:vendor_admin/custom_config/util/image_base64.dart';
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

  @override
  Widget build(BuildContext context) {
    // model
    final model = Provider.of<AddBrandModel>(context);
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
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
            const SizedBoxHeight(height: 50),
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
                      model,
                      model.choosedImage,
                    ),
                    if (isClickedAdd && model.choosedImage == null)
                      controller.showNoImageError(context),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      color.secondaryColor,
                    ),
                  ),
                  onPressed: () {
                    model.chooseImageFun();
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
            const SizedBoxHeight(height: 50),
            ProfileSettingBtn(
              btnName: "Add",
              btnFunction: () {
                isClickedAdd = true;
                if (controller.formKey.currentState!.validate() &&
                    model.choosedImage != null) {
                  controller.addBrand(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
