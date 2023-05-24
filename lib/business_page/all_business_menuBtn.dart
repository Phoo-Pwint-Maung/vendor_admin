import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/alert_box.dart';

class AllBusinessMenuBtn extends StatefulWidget {
  final String businessName;
  const AllBusinessMenuBtn({
    super.key,
    required this.businessName,
  });

  @override
  State<AllBusinessMenuBtn> createState() => _AllBusinessMenuBtnState();
}

class _AllBusinessMenuBtnState extends State<AllBusinessMenuBtn> {
  @override
  Widget build(BuildContext context) {
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
                );
              });
        }
      },
    );
  }
}
