import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_admin/custom_config/util/image_base64.dart';

class UpdateCategoryModel extends ChangeNotifier {
  XFile? choosedImage;
  String? imageStr;

  // Keeping Image String , choosed image
  Future<void> chooseAndKeepImage() async {
    final XFile? image = await imageBase64();

    if (image != null) {
      choosedImage = image; // Keep in model to show preview
      List<int> singleImageBytes = await image.readAsBytes();
      String singleImageBase =
          'data:image/png;base64,${base64Encode(singleImageBytes)}';
      imageStr = singleImageBase;
    }

    notifyListeners();
  }
}
