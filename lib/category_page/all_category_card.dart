import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';

class AllCategoryCard extends StatefulWidget {
  final String name;
  final String url;
  const AllCategoryCard({
    super.key,
    required this.name,
    required this.url,
  });

  @override
  State<AllCategoryCard> createState() => _AllCategoryCardState();
}

class _AllCategoryCardState extends State<AllCategoryCard> {
  final color = ColorConst();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      color: color.secondaryColor,
      child: Column(
        children: [
          const SizedBoxHeight(height: 10),
          Image.network(
            widget.url,
            width: screenWidth * 0.3,
            height: 80,
          ),

          // ***** only 20 characters allows
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              widget.name,
              style: TextStyle(
                color: color.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
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
                      fontSize: 16,
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
                      fontSize: 16,
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
