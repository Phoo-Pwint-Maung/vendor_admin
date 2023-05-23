import 'package:flutter/material.dart';

class AddCategoryController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController categoryName = TextEditingController();
  // Category Name Validation
  String? validateCategoryName(String? input) {
    if (input!.isEmpty) {
      return "* Type Something";
    }
    return null;
  }
}
