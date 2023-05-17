import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/custom_config/ui/navbar_item.dart';
import 'package:vendor_admin/custom_config/ui/navbar_mode.dart';
import 'package:vendor_admin/custom_config/ui/register_components.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final color = ColorConst();
  final ExpansionTileController controller = ExpansionTileController();
  final scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    var currentPage = Provider.of<NavBarModel>(context).currentPage;
    return Consumer<NavBarModel>(builder: (context, navBarModel, _) {
      return Drawer(
        backgroundColor: color.ternaryColor,
        child: SingleChildScrollView(
          controller: scroll,
          child: Column(
            children: [
              // Drawer header
              UserAccountsDrawerHeader(
                accountName: Text('John Doe'),
                accountEmail: Text('john.doe@example.com'),
                currentAccountPicture: CircleAvatar(
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

              // ExpansionTile(
              //   leading: Icon(Icons.card_travel),
              //   controller: controller,
              //   title: Text("Brands"),
              //   children: [
              //     ListTile(
              //       leading: Icon(Icons.card_travel),
              //       title: Text("All Brands"),
              //       onTap: () => null,
              //       hoverColor: color.secondaryColor,
              //       splashColor: color.primaryColor,
              //     ),
              //     ListTile(
              //       leading: Icon(Icons.card_travel),
              //       title: Text("Add Brand"),
              //       onTap: () => null,
              //       hoverColor: color.secondaryColor,
              //       splashColor: color.primaryColor,
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      );
    });
  }
}
