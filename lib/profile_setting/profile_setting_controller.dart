import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/profile_setting/password_change/pass_change_screen.dart';
import 'package:vendor_admin/profile_setting/profile_edit/profile_edit_model.dart';
import 'package:vendor_admin/profile_setting/profile_edit/profile_edit_screen.dart';
import 'package:vendor_admin/profile_setting/profile_setting_component.dart';

class ProfileSettingController {
  // Show Profile Data Box
  ProfileDataBox showProfileData({
    required BuildContext context,
    required String title,
  }) {
    final signin = Provider.of<SignInData>(context);
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    return ProfileDataBox(
      child: Row(
        children: [
          LeftText(width: screenWidth * 0.25, text: title),
          LeftText(width: screenWidth * 0.1, text: ":"),
          if (title == "Name")
            RightText(
              text: signin.name,
            ),
          if (title == "Email")
            RightText(
              text: signin.email,
            ),
        ],
      ),
    );
  }

  // Show Profile Photo
  CircleAvatar showPhoto({required BuildContext context}) {
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    final profileEditModel = Provider.of<ProfileEditModel>(context);
    return profileEditModel.newImage.isEmpty
        ? CircleAvatar(
            minRadius: screenWidth * 0.2,
            backgroundImage: Image.asset(
              'assets/images/default_profile_pic.png',
              fit: BoxFit.contain,
            ).image,
          )
        : CircleAvatar(
            maxRadius: screenWidth * 0.2,
            backgroundImage: Image.network(
              profileEditModel.newImage,
            ).image,
          );
  }

  void goProfileEditPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileEditScreen(),
      ),
    );
  }

  void goPasswordChangePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordChangeScreen(),
      ),
    );
  }
}
