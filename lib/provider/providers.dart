import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/brand_page/add_brand_model.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/business_page/add_business_model.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/business_page/update_business/update_business_model.dart';
import 'package:vendor_admin/category_page/add_category_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/category_page/update_category/update_category_model.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';
import 'package:vendor_admin/profile_setting/password_change/pass_change_model.dart';
import 'package:vendor_admin/profile_setting/profile_edit/profile_edit_model.dart';
import 'package:vendor_admin/vendor_manage_page/vendor_manage_model.dart';

final List<SingleChildWidget> provider = [
  ChangeNotifierProvider(
    create: (context) => NavBarModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => SignInData(),
  ),
  ChangeNotifierProvider(
    create: (context) => ProfileEditModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => PassChangeModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => AllBrandData(),
  ),
  ChangeNotifierProvider(
    create: (context) => AddBrandModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => AllBusinessData(),
  ),
  ChangeNotifierProvider(
    create: (context) => AddBusinessModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => UpdateBusinessModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => VendorManageModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => AllCategoryData(),
  ),
  ChangeNotifierProvider(
    create: (context) => AddCategoryModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => UpdateCategoryModel(),
  ),
];
