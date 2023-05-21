import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/Authentication/model/sign_up_model.dart';
import 'package:vendor_admin/navbar/drawer_header.dart';
import 'package:vendor_admin/navbar/navbar_item.dart';
import 'package:vendor_admin/navbar/navbar_controller.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final controller = NavBarController();
  final color = ColorConst();
  @override
  Widget build(BuildContext context) {
    return Consumer3<NavBarModel, SignInData, SignUpData>(
        builder: (context, navBarModel, signin, signup, _) {
      return Drawer(
        backgroundColor: color.ternaryColor,
        child: SingleChildScrollView(
          controller: controller.scroll,
          child: Column(
            children: [
              signup.fromSignUp
                  ? NavBarHeader(userName: signup.name, userEmail: signup.email)
                  : NavBarHeader(
                      userName: signin.name, userEmail: signin.email),
              NavBarItem(
                id: 1,
                icon: Icons.home,
                title: "Home",
                selected: navBarModel.currentPage == DrawerSection.home
                    ? true
                    : false,
              ),
              NavBarItem(
                id: 2,
                icon: Icons.home,
                title: "All Brand",
                selected: navBarModel.currentPage == DrawerSection.allBrand
                    ? true
                    : false,
              ),
              ExpansionTile(
                leading: Icon(Icons.card_travel),
                controller: controller.expansionTile,
                title: Text("Brands"),
                children: [
                  ListTile(
                    leading: Icon(Icons.card_travel),
                    title: Text("All Brands"),
                    onTap: () => null,
                    hoverColor: color.secondaryColor,
                    splashColor: color.primaryColor,
                  ),
                  ListTile(
                    leading: Icon(Icons.card_travel),
                    title: Text("Add Brand"),
                    onTap: () => null,
                    hoverColor: color.secondaryColor,
                    splashColor: color.primaryColor,
                  ),
                ],
              ),
              NavBarItem(
                id: 9,
                icon: Icons.settings,
                title: "Profile Setting",
                selected:
                    navBarModel.currentPage == DrawerSection.profileSetting
                        ? true
                        : false,
              ),
              NavBarItem(
                id: 10,
                icon: Icons.arrow_back_ios_new,
                title: "LogOut",
                selected: navBarModel.currentPage == DrawerSection.logOut
                    ? true
                    : false,
              ),
            ],
          ),
        ),
      );
    });
  }
}
