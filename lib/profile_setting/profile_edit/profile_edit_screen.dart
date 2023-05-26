import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';
import 'package:vendor_admin/profile_setting/profile_edit/profile_edit_controller.dart';
import 'package:vendor_admin/profile_setting/profile_edit/profile_edit_model.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final ImagePicker picker = ImagePicker();

  // color
  final color = ColorConst();

  final controller = ProfileEditController();

  bool isApiLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final profileEdit = Provider.of<ProfileEditModel>(context, listen: false);
    profileEdit.editImage = null;
    controller.putName(context);
  }

  @override
  Widget build(BuildContext context) {
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    final profileSetting = Provider.of<ProfileEditModel>(context);

    return Scaffold(
      backgroundColor: color.ternaryColor,
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_new_sharp),
          onTap: () => Navigator.pop(context),
        ),
        backgroundColor: color.secondaryColor,
        title: const Text("Profile Edit"),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          width: screenWidth,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            children: [
              profileSetting.editImage == null
                  ? profileSetting.newImage != ""
                      ? CircleAvatar(
                          minRadius: screenWidth * 0.2,
                          backgroundImage: Image.network(
                            profileSetting.newImage,
                          ).image,
                        )
                      : CircleAvatar(
                          minRadius: screenWidth * 0.2,
                          backgroundImage: Image.asset(
                            'assets/images/default_profile_pic.png',
                            fit: BoxFit.contain,
                          ).image,
                        )
                  : CircleAvatar(
                      maxRadius: screenWidth * 0.2,
                      backgroundImage: Image.file(
                        File(profileSetting.editImage!.path),
                        // width: 150,
                        fit: BoxFit.contain,
                      ).image,
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
                  profileSetting.chooseImage();
                },
                child: Text(
                  "choose image",
                  style: TextStyle(
                    color: color.primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: screenWidth * 0.8,
                child: Form(
                  key: controller.formKey,
                  child: TextFormField(
                    validator: (value) {
                      return controller.validateName(value);
                    },
                    controller: controller.name,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
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
                  if (controller.formKey.currentState!.validate()) {
                    setState(() {
                      isApiLoading = true; // Set the flag to true
                    });
                    // If validation steps Success, Go to Home Page
                    controller.savedChange(context).whenComplete(() {
                      setState(() {
                        isApiLoading = false;
                      });
                    });
                  }
                },
                child: const Text("Save Change"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
