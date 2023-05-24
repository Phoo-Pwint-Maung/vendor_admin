import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

class AllBrandCard extends StatefulWidget {
  final String brandName;
  const AllBrandCard({
    super.key,
    required this.brandName,
  });

  @override
  State<AllBrandCard> createState() => _AllBrandCardState();
}

class _AllBrandCardState extends State<AllBrandCard> {
  final color = ColorConst();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      color: color.secondaryColor,
      child: Column(
        children: [
          Image.asset(
            'assets/images/purpeech.jpg',
            width: screenWidth * 0.2,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Text(
              widget.brandName,
              style: TextStyle(
                color: color.primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Add Category',
              style: TextStyle(
                color: color.ternaryColor,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                TextButton(
                  style: const ButtonStyle(),
                  onPressed: () {
                    // Perform some action
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: color.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Perform some action
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: color.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
