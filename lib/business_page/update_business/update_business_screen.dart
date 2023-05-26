import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/business_page/add_business_model.dart';
import 'package:vendor_admin/business_page/all_business_controller.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/business_page/update_business/update_business_controller.dart';
import 'package:vendor_admin/business_page/update_business/update_business_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/business_page/add_business_controller.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
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

  List<AllBusinessModel> previewData = [];
  @override
  void initState() {
    super.initState();

    setState(() {
      previewData = updateController.selectedBusinessData(context, widget.id);
    });
  }

  bool isApiCallInProgress = false; // Flag to track API call status
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer2<UpdateBusinessModel, NavBarModel>(
        builder: (context, model, navBarModel, _) {
      return Scaffold(
        appBar: AppBar(
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
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            width: screenWidth,
            child: Column(
              children: [
                MainTitle(
                    titleName: "Update ${previewData.first.name} Business"),
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
                                  previewData.first.mediaUrl,
                                  model.isSelectImage,
                                )
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
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
                          print("click");
                          if (updateController.formKey.currentState!
                              .validate()) {
                            setState(() {
                              isApiCallInProgress =
                                  true; // Set the flag to true
                            });

                            updateController
                                .updateBusiness(context, widget.id)
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
                  child: const Text(
                    "Add",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
