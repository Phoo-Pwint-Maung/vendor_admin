import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';

class VendorList extends StatelessWidget {
  final String status;
  final Color statusColor;
  final void Function()? btnFun;
  final String vendorId;
  final String shopName;
  final String email;
  const VendorList({
    super.key,
    required this.status,
    required this.statusColor,
    required this.btnFun,
    required this.vendorId,
    required this.shopName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: screenWidth * 0.13,
              child: Text(
                vendorId,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.05,
            ),
            SizedBox(
              width: screenWidth * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shopName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: screenWidth * 0.2,
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        statusColor,
                      ),
                    ),
                    onPressed: btnFun,
                    child: Text(
                      status,
                      style: TextStyle(
                        color: color.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1.3,
          color: color.secondaryColor,
        ),
      ],
    );
  }
}
