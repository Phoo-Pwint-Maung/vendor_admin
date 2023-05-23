import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

class AllBusinessController {
  final dio = Dio();
  void getAllBusiness(BuildContext context) async {
    List<String> idTokenList = idAndToken(context);
    final allBusinessModel =
        Provider.of<AllBusinessModel>(context, listen: false);

    id = idTokenList[0];
    token = idTokenList[1];

    final url = "$mainUrl/businesses?admin_id=$id";
    final response = await dio.get(
      url,
      options: Options(
        headers: {
          "authorization": "Bearer $token",
        },
        contentType: Headers.jsonContentType,
      ),
    );

    // Error Handling Left

    // Error Handling Left
    final int count = int.parse(response.data["count"].toString());
    final List<dynamic> list = response.data["data"];

    print(list[0]["name"]);

    allBusinessModel.allBusinessData(count, list);

    // final resultEncodeString = jsonEncode(response.data);
    // final resultDecode = jsonDecode(resultEncodeString);
    // // Putting Result to Model Map<String,dynamic>
    // allBrandModel.getAllBrand(resultDecode);
  }
}
