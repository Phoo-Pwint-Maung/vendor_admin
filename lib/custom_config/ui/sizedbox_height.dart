import 'package:flutter/material.dart';

class SizedBoxHeight extends StatelessWidget {
  final double? height;
  const SizedBoxHeight({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
