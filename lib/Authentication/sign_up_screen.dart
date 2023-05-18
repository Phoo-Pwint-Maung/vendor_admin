import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_up_model.dart';
import 'package:vendor_admin/Authentication/sign_in_screen.dart';
import 'package:vendor_admin/Authentication/sign_up_controller.dart';
import 'package:vendor_admin/custom_config/ui/register_components.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Controller
  final controller = SignUpFormController();
  // color
  final color = ColorConst();

  @override
  Widget build(BuildContext context) {
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    final model = Provider.of<SignUpModel>(context);

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
                      const RegisterTitle(titleName: "Sign Up"),
                      const SizedBox(
                        height: 20,
                      ),
                      RegisterSubTitle(
                        firstText: "Already have an account? ",
                        secondText: "Sing In >>",
                        changePage: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ),
                            );
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
                              text: "Name",
                              formIcon: Icons.person,
                              keyboardType: TextInputType.name,
                              iconColor: color.black,
                              textEditingController: controller.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "type something";
                                }
                                return null;
                              },
                            ),
                            RegisterFormfield(
                              text: "Email",
                              formIcon: Icons.mail,
                              keyboardType: TextInputType.emailAddress,
                              iconColor: color.black,
                              textEditingController: controller.email,
                              inputFormatter: [
                                FilteringTextInputFormatter.deny(
                                  RegExp(" "),
                                ),
                              ],
                              validator: (value) {
                                return controller.validateEmail(value);
                              },
                            ),
                            RegisterFormfield(
                              text: "Password",
                              formIcon: Icons.password,
                              keyboardType: TextInputType.text,
                              iconColor: color.black,
                              textEditingController: controller.password,
                              validator: (value) {
                                return controller.validatePassword(value);
                              },
                            ),
                          ],
                        ),
                      ),
                      RegisterButton(
                        btnPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            // If validation steps Success, Go to Home Page
                            controller.register();

                            print(model.emailError);
                            // if (model.emailError.isNotEmpty) {
                            //   print(model.emailError);
                            //   controller.showErrorMessage(
                            //       model.emailError, context);
                            // }
                          }
                        },
                        btnName: "Register",
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
