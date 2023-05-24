import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:vendor_admin/custom_config/util/image_base64.dart';

class AddBusinessModel extends ChangeNotifier {
  XFile? choosedImage;
  String? imageStr;
  String? id;
  String? name;
  String? address;
  String? mediaId;
  String? mediaUrl;

  void getAddBusinessData({
    required String businessName,
    required String businessAddress,
    required String id,
    required String mediaId,
    required String mediaUrl,
  }) {
    if (name != null) {
      id = id;
      name = businessName;
      address = businessAddress;
      mediaId = mediaId;
      mediaUrl = mediaUrl;
    }

    notifyListeners();
  }

  // Keeping Image String , choosed image
  Future<void> chooseAndKeepImage() async {
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
