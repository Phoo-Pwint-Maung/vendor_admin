import 'package:flutter/material.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Text("All Product")],
      ),
    );
  }
}
