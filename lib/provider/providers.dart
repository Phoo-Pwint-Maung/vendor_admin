import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vendor_admin/testing/controller/test_controller.dart';

final List<SingleChildWidget> provider = [
  ChangeNotifierProvider(
    create: (context) => PlayLists(),
  )
];
