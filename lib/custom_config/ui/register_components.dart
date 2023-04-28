import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

// This Register Components include TextFormField and Button
// Default RegisterFormField and // Default RegisterButton
// Default RegisterFormField
class RegisterFormfield extends StatefulWidget {
  final String text;
  final IconData formIcon;
  final String? helperText;
  final Color? iconColor;
  const RegisterFormfield(
      {super.key,
      required this.text,
      required this.formIcon,
      this.helperText,
      this.iconColor});

  @override
  State<RegisterFormfield> createState() => _RegisterFormfieldState();
}

class _RegisterFormfieldState extends State<RegisterFormfield> {
  @override
  Widget build(BuildContext context) {
    // color
    final color = ColorConst();

    return Column(
      children: [
        TextFormField(
          // This is the event for tap other area of formfield and unfocus of this
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },

          decoration: InputDecoration(
            helperText: widget.helperText,
            labelText: widget.text,
            labelStyle: TextStyle(
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
            enabledBorder: OutlineInputBorder(
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

// Default RegisterButton

class RegisterButton extends StatefulWidget {
  final String text;
  const RegisterButton({super.key, required this.text});

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  // color
  final color = ColorConst();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 10,
            ),
            side: BorderSide(
              color: color.black,
              width: 2,
            ),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: color.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
