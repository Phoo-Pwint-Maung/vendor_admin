import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/custom_config/util/image_base64.dart';

class UpdateBusinessModel extends ChangeNotifier {
  XFile? choosedImage;
  String? imageStr;
  bool isSelectImage = false;

  AllBusinessModel? addNewBusiness;

  // Keeping Image String , choosed image
  Future<void> chooseAndKeepImage() async {
    final XFile? image = await imageBase64();

    if (image != null) {
      choosedImage = image;
      isSelectImage = true;
      List<int> singleImageBytes = await choosedImage!.readAsBytes();
      String singleImageBase =
          'data:image/png;base64,${base64Encode(singleImageBytes)}';

      imageStr = singleImageBase;
    } else {
      return;
    }

    notifyListeners();
  }
}
