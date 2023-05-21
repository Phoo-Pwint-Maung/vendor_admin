import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

// color
final color = ColorConst();

class LeftText extends StatefulWidget {
  final double width;
  final String text;
  const LeftText({super.key, required this.width, required this.text});

  @override
  State<LeftText> createState() => _LeftTextState();
}

class _LeftTextState extends State<LeftText> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        widget.text,
        style: TextStyle(
          color: color.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      width: widget.width,
    );
  }
}

class RightText extends StatefulWidget {
  final String text;
  const RightText({super.key, required this.text});

  @override
  State<RightText> createState() => _RightTextState();
}

class _RightTextState extends State<RightText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(color: color.black, fontSize: 16),
    );
  }
}

// Show Data in Profile Setting Page
class ProfileDataBox extends StatefulWidget {
  final Widget child;
  const ProfileDataBox({super.key, required this.child});

  @override
  State<ProfileDataBox> createState() => _ProfileDataBoxState();
}

class _ProfileDataBoxState extends State<ProfileDataBox> {
  @override
  Widget build(BuildContext context) {
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      color: color.secondaryColor.withOpacity(0.5),
      child: widget.child,
    );
  }
}

// Buttons in Profile Setting Page
class ProfileSettingBtn extends StatefulWidget {
  final void Function()? btnFunction;
  final String btnName;
  const ProfileSettingBtn({
    super.key,
    this.btnFunction,
    required this.btnName,
  });

  @override
  State<ProfileSettingBtn> createState() => _ProfileSettingBtnState();
}

class _ProfileSettingBtnState extends State<ProfileSettingBtn> {
  @override
  Widget build(BuildContext context) {
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            color.secondaryColor,
          ),
        ),
        onPressed: widget.btnFunction,
        child: Text(
          widget.btnName,
          style: TextStyle(
            fontSize: 18,
            color: color.white,
          ),
        ),
      ),
    );
  }
}

// () {
          // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ProfileEditScreen(),
        //     ),
        //   );
        // }