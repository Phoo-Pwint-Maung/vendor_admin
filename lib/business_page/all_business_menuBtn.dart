import 'package:flutter/material.dart';
import 'package:vendor_admin/business_page/delete_business/delete_business_controller.dart';
import 'package:vendor_admin/business_page/delete_business/delete_business_screen.dart';
import 'package:vendor_admin/business_page/update_business/update_business_controller.dart';
import 'package:vendor_admin/business_page/update_business/update_business_screen.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/alert_box.dart';

class AllBusinessMenuBtn extends StatefulWidget {
  final String businessName;
  final String businessId;
  const AllBusinessMenuBtn({
    super.key,
    required this.businessName,
    required this.businessId,
  });

  @override
  State<AllBusinessMenuBtn> createState() => _AllBusinessMenuBtnState();
}

class _AllBusinessMenuBtnState extends State<AllBusinessMenuBtn> {
  final deleteController = DeleteBusinessController();
  final updateController = UpdateBusinessController();

  @override
  Widget build(BuildContext context) {
    final businessId = widget.businessId;
    return PopupMenuButton(
      icon: const Icon(Icons.menu),
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'edit',
            child: Text('Edit'),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text('Delete'),
          ),
        ];
      },
      onSelected: (String value) {
        if (value == 'edit') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: widget.businessName,
                  content: "Go to edit this business",
                  firstBtnName: "Cancel",
                  secondBtnName: "Edit",
                  contentColor: color.white,
                  firstBtnColor: color.ternaryColor,
                  secondBtnColor: color.primaryColor,
                  backgroundColor: color.secondaryColor,
                  // Cancel button
                  firstBtnFun: () {
                    Navigator.pop(context);
                  },
                  // Edit button
                  secondBtnFun: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UpdateBusinessScreen(
                            id: businessId,
                          );
                        },
                      ),
                    );
                  },
                );
              });
        } else if (value == 'delete') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: widget.businessName,
                content: 'Are you sure "Delete" this business?',
                firstBtnName: "Cancel",
                secondBtnName: "Delete",
                contentColor: color.white,
                firstBtnColor: color.white,
                secondBtnColor: color.red,
                backgroundColor: color.black,
                // Cancel Button
                firstBtnFun: () {
                  Navigator.pop(context);
                },
                // Delete Button
                secondBtnFun: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return DeleteBusinessScreen(
                      businessId: businessId,
                    );
                  }));
                },
              );
            },
          );
        }
      },
    );
  }
}
