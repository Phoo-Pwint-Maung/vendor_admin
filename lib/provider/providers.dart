import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vendor_admin/custom_config/ui/navbar_mode.dart';

final List<SingleChildWidget> provider = [
  ChangeNotifierProvider(
    create: (context) => NavBarModel(),
  )
];
