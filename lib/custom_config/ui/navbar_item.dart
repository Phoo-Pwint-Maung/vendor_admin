import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/custom_config/ui/navbar_mode.dart';
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
            if (widget.id == 1) {
              navBarModel.changePage(DrawerSection.home);
            } else if (widget.id == 2) {
              navBarModel.changePage(DrawerSection.allBrand);
            }
          },
        ),
      );
    });
  }
}
