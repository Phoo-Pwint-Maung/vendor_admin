import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/business_page/add_business_model.dart';
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
  bool isApiCallInProgress = false; // Flag to track API call status
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer2<AddBusinessModel, NavBarModel>(
        builder: (context, model, navBarModel, _) {
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
                          model.choosedImage != null) {
                        setState(() {
                          isApiCallInProgress = true; // Set the flag to true
                        });

                        controller.addNewBusiness(context).then((_) {
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
