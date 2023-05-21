import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';
import 'package:vendor_admin/profile_setting/password_change/pass_change_controller.dart';
import 'package:vendor_admin/profile_setting/password_change/pass_change_model.dart';
import 'package:vendor_admin/profile_setting/password_change/pass_formfield.dart';
import 'package:vendor_admin/profile_setting/profile_setting_component.dart';

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  // color
  final color = ColorConst();
  final controller = PassChangeController();
  final signUpController = SignUpFormController();

  @override
  Widget build(BuildContext context) {
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    final passError = Provider.of<PassChangeModel>(context, listen: false);

    return Scaffold(
      backgroundColor: color.ternaryColor,
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_new_sharp),
          onTap: () => Navigator.pop(context),
        ),
        backgroundColor: color.secondaryColor,
        title: const Text("Password Change"),
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
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Text(
                      "Set A New Password",
                      style: TextStyle(
                        color: color.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBoxHeight(height: 50),
                    PassFormField(
                      textEditingController: controller.oldPassword,
                      hintText: "Old Password",
                      validate: (value) {
                        return signUpController.validatePassword(value);
                      },
                    ),
                    SizedBoxHeight(height: 30),
                    PassFormField(
                      textEditingController: controller.newPassword,
                      hintText: "New Password",
                      validate: (value) {
                        // return signUpController.validatePassword(value);
                      },
                    ),
                    SizedBoxHeight(height: 30),
                    PassFormField(
                      textEditingController: controller.newPasswordComfirmation,
                      hintText: "New Password",
                      validate: (value) {
                        // return signUpController.validatePassword(value);
                      },
                    ),
                  ],
                ),
              ),
              SizedBoxHeight(height: 20),
              ProfileSettingBtn(
                btnName: "Change Password",
                btnFunction: () {
                  if (controller.formKey.currentState!.validate()) {
                    // If validation steps Success, Go to Home Page
                    controller.passwordChanged(context);
                  }
                },
              ),
              SizedBoxHeight(height: 40),
              // Error Box
              if (passError.passwordError.isNotEmpty)
                Container(
                  width: screenWidth * 0.8,
                  child: Column(
                    children: [
                      Text(
                        "* Follow The Rule *",
                        style: TextStyle(color: color.red, fontSize: 18),
                      ),
                      SizedBoxHeight(height: 20),
                      controller.errorBox(context)
                    ],
                  ),
                )
              // Error Box
            ],
          ),
        ),
      ),
    );
  }
}
