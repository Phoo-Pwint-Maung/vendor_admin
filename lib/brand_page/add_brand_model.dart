import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_admin/custom_config/util/image_base64.dart';

class AddBrandModel extends ChangeNotifier {
  XFile? choosedImage;
  String? imageStr;

  Future<void> chooseImageFun() async {
    final XFile? image = await imageBase64();

    if (image != null) {
      choosedImage = image;
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
