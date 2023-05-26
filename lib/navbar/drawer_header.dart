import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';
import 'package:vendor_admin/profile_setting/profile_edit/profile_edit_model.dart';

class NavBarHeader extends StatefulWidget {
  final String userName;
  final String userEmail;

  const NavBarHeader(
      {super.key, required this.userName, required this.userEmail});

  @override
  State<NavBarHeader> createState() => _NavBarHeaderState();
}

class _NavBarHeaderState extends State<NavBarHeader> {
  final color = ColorConst();

  @override
  Widget build(BuildContext context) {
    final profileSetting = Provider.of<ProfileEditModel>(context);
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: color.secondaryColor,
      ),
      accountName: Text(
        widget.userName,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      accountEmail: Text(
        widget.userEmail,
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
      currentAccountPicture: profileSetting.newImage.isEmpty
          ? CircleAvatar(
              backgroundImage: Image.asset(
                'assets/images/default_profile_pic.png',
                fit: BoxFit.contain,
              ).image,
            )
          : CircleAvatar(
              backgroundImage: Image.network(
                profileSetting.newImage,
              ).image,
            ),
    );
  }
}
