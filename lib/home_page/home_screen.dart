import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/Authentication/model/sign_in_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<SignInModel>(context).signInAuthToken;
    return Container(
      child: Column(
        children: [
          Text("Auth token is : $token"),
        ],
      ),
    );
  }
}
