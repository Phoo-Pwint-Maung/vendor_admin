import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';

final List<SingleChildWidget> provider = [
  ChangeNotifierProvider(
    create: (context) => NavBarModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => SignInModel(),
  ),
];
