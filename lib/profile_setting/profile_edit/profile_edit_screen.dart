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
  XFile? image;
  final ImagePicker picker = ImagePicker();

  // color
  final color = ColorConst();

  final controller = ProfileEditController();

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
          child: Icon(Icons.arrow_back_ios_new_sharp),
          onTap: () => Navigator.pop(context),
        ),
        backgroundColor: color.secondaryColor,
        title: Text("Profile Edit"),
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
                  ? profileSetting.image != null
                      ? CircleAvatar(
                          minRadius: screenWidth * 0.2,
                          backgroundImage: Image.file(
                            File(profileSetting.image!.path),
                            // width: 150,
                            fit: BoxFit.contain,
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
                onPressed: () {
                  profileSetting.chooseImage();
                },
                child: Text("choose image"),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                child: Form(
                  key: controller.formKey,
                  child: TextFormField(
                    validator: (value) {
                      return controller.validateName(value);
                    },
                    controller: controller.name,
                  ),
                ),
                width: screenWidth * 0.8,
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    color.secondaryColor,
                  ),
                ),
                onPressed: () {
                  profileSetting.isSaved = true;
                  profileSetting.saved();
                  if (controller.formKey.currentState!.validate()) {
                    // If validation steps Success, Go to Home Page
                    controller.savedChange(context);
                  }
                },
                child: Text("Save Change"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
