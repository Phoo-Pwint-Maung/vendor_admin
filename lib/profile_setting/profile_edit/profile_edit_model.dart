import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditModel extends ChangeNotifier {
  XFile? image;
  XFile? editImage;
  String? imageStr;
  String newImage = "";

  final ImagePicker picker = ImagePicker();

  Future<void> chooseImage() async {
    XFile? imageChoose = await picker.pickImage(source: ImageSource.gallery);

    if (imageChoose != null) {
      editImage = imageChoose;
      List<int> singleImageBytes = await imageChoose.readAsBytes();
      String singleImageBase =
          'data:image/png;base64,${base64Encode(singleImageBytes)}';

      imageStr = singleImageBase;
    }

    notifyListeners();
  }

  void saved(String str) {
    newImage = str;
    notifyListeners();
  }
}
