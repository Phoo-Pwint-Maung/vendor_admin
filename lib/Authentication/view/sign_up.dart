import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // color
  final color = ColorConst();
  // font size
  final fontSizeConst = FontSizeConst();
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: color.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenHight * 0.25,
              width: screenWidth,
              decoration: BoxDecoration(color: color.primaryColor),
              child: Center(
                child: SizedBox(
                  width: screenWidth * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: fontSizeConst.biggestFontSize * textScale,
                            fontWeight: FontWeight.bold,
                            color: color.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontSize: fontSizeConst.secondFontSize,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign in >>',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: color.white,
                                fontSize: fontSizeConst.thirdFontSize,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: color.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
