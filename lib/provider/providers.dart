import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/Authentication/model/sign_up_model.dart';
import 'package:vendor_admin/brand_page/add_brand_model.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/business_page/add_business_model.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';
import 'package:vendor_admin/profile_setting/password_change/pass_change_model.dart';
import 'package:vendor_admin/profile_setting/profile_edit/profile_edit_model.dart';

final List<SingleChildWidget> provider = [
  ChangeNotifierProvider(
    create: (context) => NavBarModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => SignInData(),
  ),
  ChangeNotifierProvider(
    create: (context) => SignUpData(),
  ),
  ChangeNotifierProvider(
    create: (context) => ProfileEditModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => PassChangeModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => AllBrandModel(),
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
];
