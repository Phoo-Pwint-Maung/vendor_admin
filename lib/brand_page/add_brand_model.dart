import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBrandModel extends ChangeNotifier {
  XFile? choosedImage;
  String? imageStr;
  final ImagePicker imagepick = ImagePicker();

  Future<void> chooseImageFun() async {
    XFile? image = await imagepick.pickImage(source: ImageSource.gallery);

    if (image != null) {
      choosedImage = image;
      List<int> singleImageBytes = await choosedImage!.readAsBytes();
      String singleImageBase =
          'data:image/png;base64,' + base64Encode(singleImageBytes);

      imageStr = singleImageBase;
    }
    notifyListeners();
  }
}
