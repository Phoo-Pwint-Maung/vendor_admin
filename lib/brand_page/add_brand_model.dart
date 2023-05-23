import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBrandModel extends ChangeNotifier {
  XFile? choosedImage;
  final ImagePicker imagepick = ImagePicker();

  Future<void> chooseImageFun() async {
    XFile? image = await imagepick.pickImage(source: ImageSource.gallery);

    if (image != null) {
      choosedImage = image;
    }
    notifyListeners();
  }
}
