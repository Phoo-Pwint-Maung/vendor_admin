import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
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
    var currentPage = Provider.of<NavBarModel>(context).currentPage;
    return Consumer2<NavBarModel, SignInModel>(
        builder: (context, navBarModel, signin, _) {
      return Drawer(
        backgroundColor: color.ternaryColor,
        child: SingleChildScrollView(
          controller: controller.scroll,
          child: Column(
            children: [
              // Drawer header
              UserAccountsDrawerHeader(
                accountName: Text(signin.name),
                accountEmail: Text(signin.email),
                currentAccountPicture: const CircleAvatar(
                  child: Text('JD'),
                ),
              ),

              NavBarItem(
                id: 1,
                icon: Icons.home,
                title: "Home",
                selected: currentPage == DrawerSection.home ? true : false,
              ),
              NavBarItem(
                id: 2,
                icon: Icons.home,
                title: "All Brand",
                selected: currentPage == DrawerSection.allBrand ? true : false,
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
                id: 10,
                icon: Icons.arrow_back_ios_new,
                title: "LogOut",
                selected: currentPage == DrawerSection.logOut ? true : false,
              ),
            ],
          ),
        ),
      );
    });
  }
}
