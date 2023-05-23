import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

final color = ColorConst();

// main Title of AddBrand Page
class MainTitle extends StatelessWidget {
  final String titleName;
  const MainTitle({
    super.key,
    required this.titleName,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleName,
      style: TextStyle(
        color: color.secondaryColor,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class NameInputBox extends StatefulWidget {
  final String? Function(String?)? validation;
  final Key? formKey;
  final TextEditingController? textEditingController;
  final String? boxTitle;
  const NameInputBox({
    super.key,
    required this.validation,
    required this.formKey,
    required this.textEditingController,
    required this.boxTitle,
  });

  @override
  State<NameInputBox> createState() => _NameInputBoxState();
}

class _NameInputBoxState extends State<NameInputBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.boxTitle!,
          style: TextStyle(
            color: color.secondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: SizedBox(
            child: Form(
              key: widget.formKey,
              child: TextFormField(
                controller: widget.textEditingController,
                validator: widget.validation,
                style: TextStyle(
                  color: color.secondaryColor,
                ),
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: color.secondaryColor,
                    ),
                  ),
                ),
                cursorColor: color.secondaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
