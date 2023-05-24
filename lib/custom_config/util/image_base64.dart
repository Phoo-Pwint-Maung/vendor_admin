import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> imageBase64() async {
  final ImagePicker imagepick = ImagePicker();

  XFile? image = await imagepick.pickImage(source: ImageSource.gallery);

  return image;
}

// showPreView Choosed Image
Widget showPreviewImage(BuildContext context, dynamic model, XFile? image) {
  final screenWidth = MediaQuery.of(context).size.width;

  return image == null
      ? Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          width: screenWidth * 0.45,
          child: Image.asset("assets/images/brandImage.png"),
        )
      : Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          width: screenWidth * 0.45,
          child: Image.file(
            File(image.path),
          ),
        );
}
