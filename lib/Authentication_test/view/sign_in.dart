// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:vendor_admin/custom_config/ui/style.dart';
// import 'package:vendor_admin/custom_config/ui/register_components.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   // color
//   final color = ColorConst();

//   // form text
//   final userName = TextEditingController();
//   final email = TextEditingController();
//   final password = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final textScale = MediaQuery.of(context).textScaleFactor;
//     double screenWidth = MediaQuery.of(context).size.width;

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: color.secondaryColor,
//         body: SingleChildScrollView(
//           controller: ScrollController(),
//           child: Column(
//             children: [
//               Container(
//                 height: 200,
//                 width: screenWidth,
//                 decoration: BoxDecoration(
//                   color: color.primaryColor,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Sign In",
//                       style: TextStyle(
//                           fontSize: 24 * textScale,
//                           fontWeight: FontWeight.bold,
//                           color: color.white),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     RichText(
//                       text: TextSpan(
//                         text: 'No Account?  ',
//                         style: const TextStyle(
//                           fontSize: 14,
//                         ),
//                         children: [
//                           TextSpan(
//                             text: 'Sign Up >>',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               color: color.white,
//                               fontSize: 16,
//                             ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Navigator.pop(context);
//                               },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 20,
//                 ),
//                 width: screenWidth * 0.85,
//                 decoration: BoxDecoration(
//                   color: color.primaryColor,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: screenWidth * 0.75,
//                       child: Column(
//                         children: [
//                           RegisterFormfield(
//                             textEditingController: userName,
//                             text: "Username",
//                             formIcon: Icons.person,
//                             iconColor: color.black,
//                           ),
//                           RegisterFormfield(
//                             textEditingController: email,
//                             text: "Email",
//                             formIcon: Icons.mail,
//                             iconColor: color.black,
//                           ),
//                           RegisterFormfield(
//                             textEditingController: password,
//                             text: "Password",
//                             formIcon: Icons.key,
//                             iconColor: color.black,
//                           ),
//                           Text(
//                             'Forgot Password?',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: color.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
