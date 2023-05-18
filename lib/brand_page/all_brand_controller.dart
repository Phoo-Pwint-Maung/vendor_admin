// This is Get Api , default
import 'package:dio/dio.dart';
import 'package:vendor_admin/api/default_api.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

void getAllBrand() {
  GetApi().getApi(endPoint: "/brand");
}
