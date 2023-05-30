import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/profile_setting/profile_setting_component.dart';
import 'package:vendor_admin/profile_setting/profile_setting_controller.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({super.key});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final controller = ProfileSettingController();

  @override
  Widget build(BuildContext context) {
    final signin = Provider.of<SignInData>(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: [
          // Show Profile Photo Avatar
          controller.showPhoto(context: context),
          const SizedBoxHeight(height: 50),
          // Name Box
          controller.showProfileData(title: "Name", context: context),
          const SizedBoxHeight(height: 20),
          // Email Box
          controller.showProfileData(title: "Email", context: context),
          const SizedBoxHeight(height: 40),
          Divider(
            thickness: 2,
            color: color.secondaryColor,
          ),
          // Edit Profile Button
          ProfileSettingBtn(
            btnName: "Edit Profile",
            btnFunction: () {
              print(signin.id);
              print(signin.signInAuthToken);
              controller.goProfileEditPage(context);
            },
            btnColor: MaterialStateProperty.all<Color>(
              color.secondaryColor,
            ),
          ),
          const SizedBoxHeight(height: 20),
          // Change Password Button
          ProfileSettingBtn(
            btnName: "Change Password",
            btnFunction: () {
              controller.goPasswordChangePage(context);
            },
            btnColor: MaterialStateProperty.all<Color>(
              color.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
