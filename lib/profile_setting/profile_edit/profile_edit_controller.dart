import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';
import 'package:vendor_admin/custom_config/util/id_and_token.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';
import 'package:vendor_admin/profile_setting/profile_edit/profile_edit_model.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';

class ProfileEditController {
  final dio = Dio();
  String? nameText;
  String? profile;
  late TextEditingController? name;

  // Key
  final formKey = GlobalKey<FormState>();
  final signUpController = SignUpFormController();
  // Saved change
  Future<void> savedChange(BuildContext context) async {
    final profileEdit = Provider.of<ProfileEditModel>(context, listen: false);

    idAndToken(context);

    if (profileEdit.imageStr != null) {
      profile = profileEdit.imageStr;
      print(profile);
    }

    final String url = "$mainUrl/profile?admin_id=$adminId";
    final body = {
      "name": name!.text,
      "profile": profile,
    };

    final response = await dio.post(
      url,
      data: body,
      options: Options(
        headers: {
          "authorization": "Bearer $token",
        },
        contentType: Headers.jsonContentType,
      ),
    );

    print(response);

    try {
      if (response.statusCode == 200 &&
          response.data['error'].toString() == "false") {
        final String name = response.data["data"]["name"].toString();
        final String image = response.data["data"]["profile"].toString();

        if (image != "null") {
          // this is Success Image post
          profileEdit.saved(image);
        }

        // Store New Name

        final signInData = Provider.of<SignInData>(context, listen: false);

        signInData.name = name;
        // Navigate to ProfileSetting page
        Future.microtask(
          () {
            Navigator.pop(context);
          },
        );
      } else if (response.data['message'].toString().isNotEmpty) {
        signUpController.showSnackBar(
          context,
          response.data['message'].toString(),
        );
      } else if (response.statusCode == 500) {
        signUpController.showSnackBar(context, "Server Error");
      }
    } on DioError catch (_) {
      signUpController.showSnackBar(context, "Something Wrong");
    }
  }

// From Prefill
  void putName(BuildContext context) {
    final signinData = Provider.of<SignInData>(context, listen: false);

    nameText = signinData.name;

    name = TextEditingController(text: nameText);
  }

  // Name Validation
  String? validateName(String? input) {
    if (input!.isEmpty) {
      return "* Type Something";
    } else if (input.length < 4) {
      return "* Name must be at least 4 characters";
    }
    return null;
  }
}
