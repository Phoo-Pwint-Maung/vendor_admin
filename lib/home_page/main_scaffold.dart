import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_screen.dart';
import 'package:vendor_admin/brand_page/add_brand_screen.dart';
import 'package:vendor_admin/business_page/add_business_screen.dart';
import 'package:vendor_admin/business_page/all_business_screen.dart';
import 'package:vendor_admin/category_page/add_category_screen.dart';
import 'package:vendor_admin/category_page/all_category_screen.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';
import 'package:vendor_admin/navbar/navbar.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';
import 'package:vendor_admin/home_page/home_controller.dart';
import 'package:vendor_admin/home_page/home_screen.dart';
import 'package:vendor_admin/product_page/add_product_screen.dart';
import 'package:vendor_admin/product_page/all_product_screen.dart';
import 'package:vendor_admin/profile_setting/profile_setting_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  // color
  final color = ColorConst();
  final controller = HomeController();
  final brandName = TextEditingController();

  late Widget container;
  late String title;

  @override
  Widget build(BuildContext context) {
    var currentPage = Provider.of<NavBarModel>(context).currentPage;

    if (currentPage == DrawerSection.home) {
      container = const HomeScreen();
      title = 'Home';
    } else if (currentPage == DrawerSection.allBrand) {
      container = const AllBrandScreen();
      title = 'All Brand';
    } else if (currentPage == DrawerSection.addBrand) {
      container = const AddBrandScreen();
      title = 'Add Brand';
    } else if (currentPage == DrawerSection.allCategory) {
      container = const AllCategoryScreen();
      title = 'All Category';
    } else if (currentPage == DrawerSection.addCategory) {
      container = const AddCategoryScreen();
      title = 'Add Category';
    } else if (currentPage == DrawerSection.allBusiness) {
      container = const AllBusinessScreen();
      title = 'All Business';
    } else if (currentPage == DrawerSection.addBusiness) {
      container = const AddBusinessScreen();
      title = 'Add Business';
    } else if (currentPage == DrawerSection.allProduct) {
      container = const AllProductScreen();
      title = 'Add Product';
    } else if (currentPage == DrawerSection.addProduct) {
      container = const AddProductScreen();
      title = 'Add Product';
    } else if (currentPage == DrawerSection.profileSetting) {
      container = const ProfileSetting();
      title = 'Profile Setting';
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: color.ternaryColor,
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: color.secondaryColor,
          title: Text(title),
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
