import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

// color
final color = ColorConst();

// Default RegisterFormField and // Default RegisterButton
// RegisterTitle // RegisterSubTitle

// Default RegisterFormField
class RegisterFormfield extends StatefulWidget {
  final String text;
  final IconData formIcon;
  final Color? iconColor;
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final String? helperText;

  const RegisterFormfield({
    super.key,
    required this.text,
    required this.formIcon,
    required this.textEditingController,
    required this.keyboardType,
    this.iconColor,
    this.validator,
    this.inputFormatter,
    this.helperText,
  });

  @override
  State<RegisterFormfield> createState() => _RegisterFormfieldState();
}

class _RegisterFormfieldState extends State<RegisterFormfield> {
  @override
  Widget build(BuildContext context) {
    //This key will be used to identify the state of the form.

    return Column(
      children: [
        TextFormField(
          inputFormatters: widget.inputFormatter,
          keyboardType: widget.keyboardType,

          cursorColor: color.black,
          controller: widget.textEditingController,
          // This is the event for tap other area of formfield and unfocus of this
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          validator: widget.validator,
          decoration: InputDecoration(
            labelText: widget.text,
            labelStyle: TextStyle(
              color: color.black,
            ),
            helperText: widget.helperText,
            helperStyle: TextStyle(
              color: color.black,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
                color: color.black,
              ),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            prefixIcon: Icon(
              widget.formIcon,
              color: widget.iconColor,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

// Register Button
class RegisterButton extends StatelessWidget {
  final void Function()? btnPressed;
  final String btnName;
  const RegisterButton({
    super.key,
    required this.btnPressed,
    required this.btnName,
  });

  @override
  Widget build(BuildContext context) {
    // screen width
    double screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(screenWidth * 0.8, 40),
        backgroundColor: color.secondaryColor,
      ),
      onPressed: btnPressed,
      child: Text(
        btnName,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

// RegisterTitle
class RegisterTitle extends StatelessWidget {
  final String titleName;
  const RegisterTitle({super.key, required this.titleName});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleName,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// RegisterSubTitle
class RegisterSubTitle extends StatelessWidget {
  final String firstText;
  final String secondText;
  final GestureRecognizer? changePage;
  const RegisterSubTitle({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.changePage,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: TextStyle(
          fontSize: 14,
          color: color.black,
        ),
        children: [
          TextSpan(
            text: secondText,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: color.secondaryColor,
              fontSize: 16,
            ),
            recognizer: changePage,
          ),
        ],
      ),
    );
  }
}
