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
              ExpansionTile(
                leading: Icon(Icons.card_travel),
                controller: controller.brandExpansionTile,
                title: Text("Brands"),
                children: [
                  NavBarItem(
                    id: 2,
                    icon: Icons.home,
                    title: "All Brand",
                    selected: navBarModel.currentPage == DrawerSection.allBrand
                        ? true
                        : false,
                  ),
                  NavBarItem(
                    id: 3,
                    icon: Icons.home,
                    title: "Add Brand",
                    selected: navBarModel.currentPage == DrawerSection.addBrand
                        ? true
                        : false,
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(Icons.card_travel),
                controller: controller.categoryExpansionTile,
                title: Text("Categories"),
                children: [
                  NavBarItem(
                    id: 4,
                    icon: Icons.home,
                    title: "All Category",
                    selected:
                        navBarModel.currentPage == DrawerSection.allCategory
                            ? true
                            : false,
                  ),
                  NavBarItem(
                    id: 5,
                    icon: Icons.home,
                    title: "Add Category",
                    selected:
                        navBarModel.currentPage == DrawerSection.addCategory
                            ? true
                            : false,
                  ),
                ],
              ),
              ExpansionTile(
                leading: const Icon(Icons.card_travel),
                controller: controller.businessExpansionTile,
                title: const Text("Business"),
                children: [
                  NavBarItem(
                    id: 6,
                    icon: Icons.home,
                    title: "All Business",
                    selected:
                        navBarModel.currentPage == DrawerSection.allBusiness
                            ? true
                            : false,
                  ),
                  NavBarItem(
                    id: 7,
                    icon: Icons.home,
                    title: "Add Business",
                    selected: navBarModel.currentPage ==
                                DrawerSection.allBrand ||
                            navBarModel.currentPage == DrawerSection.addBusiness
                        ? true
                        : false,
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(Icons.card_travel),
                controller: controller.productExpansionTile,
                title: Text("Product"),
                children: [
                  NavBarItem(
                    id: 8,
                    icon: Icons.home,
                    title: "All Product",
                    selected:
                        navBarModel.currentPage == DrawerSection.allProduct
                            ? true
                            : false,
                  ),
                  NavBarItem(
                    id: 9,
                    icon: Icons.home,
                    title: "Add Product",
                    selected:
                        navBarModel.currentPage == DrawerSection.addProduct
                            ? true
                            : false,
                  ),
                ],
              ),
              NavBarItem(
                id: 10,
                icon: Icons.settings,
                title: "Profile Setting",
                selected:
                    navBarModel.currentPage == DrawerSection.profileSetting
                        ? true
                        : false,
              ),
              NavBarItem(
                id: 11,
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
