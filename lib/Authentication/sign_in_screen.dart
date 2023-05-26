import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vendor_admin/Authentication/sign_in_controller.dart';
import 'package:vendor_admin/custom_config/ui/register_components.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Controller TextEditingController and ScrollController
  final controller = SignInFormController();
  // color
  final color = ColorConst();
  bool apiCallProgress = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: color.ternaryColor,
        body: SingleChildScrollView(
          controller: controller.scroll,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                  ),
                  child: Column(
                    children: [
                      const RegisterTitle(titleName: "Sign In"),
                      const SizedBox(
                        height: 20,
                      ),
                      RegisterSubTitle(
                        firstText: "No Account? ",
                        secondText: "Sing Up >>",
                        changePage: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      )
                    ],
                  ),
                ),
                Container(
                  width: screenWidth * 0.8,
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            RegisterFormfield(
                              text: "Email",
                              formIcon: Icons.person,
                              iconColor: color.black,
                              keyboardType: TextInputType.emailAddress,
                              textEditingController: controller.email,
                              validator: (value) {
                                return controller.signUpController
                                    .validateEmail(value);
                              },
                            ),
                            RegisterFormfield(
                              text: "Password",
                              formIcon: Icons.mail,
                              iconColor: color.black,
                              keyboardType: TextInputType.emailAddress,
                              textEditingController: controller.password,
                              validator: (value) {
                                return controller.signUpController
                                    .validatePassword(value);
                              },
                            ),
                          ],
                        ),
                      ),
                      RegisterButton(
                        btnPressed: apiCallProgress
                            ? null
                            : () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  setState(() {
                                    apiCallProgress =
                                        true; // Set the flag to true
                                  });

                                  controller.login(context).whenComplete(() {
                                    setState(() {
                                      apiCallProgress =
                                          false; // Set the flag back to false
                                    });
                                  });
                                }
                              },
                        btnName: "Register",
                        backgroundColor:
                            apiCallProgress ? color.grey : color.secondaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
