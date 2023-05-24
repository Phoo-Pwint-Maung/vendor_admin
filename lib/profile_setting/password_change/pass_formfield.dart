import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

class PassFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String? Function(String?)? validate;
  const PassFormField(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.validate});

  @override
  Widget build(BuildContext context) {
    // color
    final color = ColorConst();
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: TextFormField(
        controller: textEditingController,
        validator: validate,
        style: TextStyle(
          color: color.secondaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: color.secondaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: color.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
