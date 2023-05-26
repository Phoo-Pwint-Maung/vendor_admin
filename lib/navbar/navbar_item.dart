import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/log_out_controller.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';
import 'package:vendor_admin/custom_config/ui/register_components.dart';

class NavBarItem extends StatefulWidget {
  final int id;
  final IconData? icon;
  final String title;
  final bool selected;
  const NavBarItem({
    super.key,
    required this.id,
    required this.icon,
    required this.title,
    required this.selected,
  });

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarModel>(builder: (context, navBarModel, _) {
      return Material(
        color: widget.selected ? color.secondaryColor : Colors.transparent,
        child: ListTile(
          leading: Icon(
            widget.icon,
            color: widget.selected ? color.white : color.black,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              color: widget.selected ? color.white : color.black,
            ),
          ),
          onTap: () {
            print("selecting");
            if (widget.id == 1) {
              navBarModel.changePage(DrawerSection.home);
            } else if (widget.id == 2) {
              navBarModel.changePage(DrawerSection.allBrand);
            } else if (widget.id == 3) {
              navBarModel.changePage(DrawerSection.addBrand);
            } else if (widget.id == 4) {
              navBarModel.changePage(DrawerSection.allCategory);
            } else if (widget.id == 5) {
              navBarModel.changePage(DrawerSection.addCategory);
            } else if (widget.id == 6) {
              navBarModel.changePage(DrawerSection.allBusiness);
            } else if (widget.id == 7) {
              navBarModel.changePage(DrawerSection.addBusiness);
            } else if (widget.id == 8) {
              navBarModel.changePage(DrawerSection.allProduct);
            } else if (widget.id == 9) {
              navBarModel.changePage(DrawerSection.addProduct);
            } else if (widget.id == 10) {
              // Profile Setting
              navBarModel.changePage(DrawerSection.profileSetting);
            } else if (widget.id == 11) {
              // LogOut
              final controller = LogOutController();
              controller.logOut(context);
            }
          },
        ),
      );
    });
  }
}
