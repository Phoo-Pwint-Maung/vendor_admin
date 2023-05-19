import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_admin/brand_page/all_brand_screen.dart';
import 'package:vendor_admin/navbar/navbar.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';
import 'package:vendor_admin/home_page/home_controller.dart';
import 'package:vendor_admin/home_page/home_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final controller = HomeController();
  final brandName = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  late Widget container;

  @override
  Widget build(BuildContext context) {
    var currentPage = Provider.of<NavBarModel>(context).currentPage;

    if (currentPage == DrawerSection.home) {
      container = HomeScreen();
    } else if (currentPage == DrawerSection.allBrand) {
      container = AllBrandScreen();
    }
    return SafeArea(
      child: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: SingleChildScrollView(
          controller: controller.scroll,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: container,
              )
            ],
          ),
        ),
      ),
    );
  }
}
