import 'package:flutter/material.dart';
import 'package:vendor_admin/business_page/delete_business/delete_business_controller.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/alert_box.dart';

class AllBrandMenuBtn extends StatefulWidget {
  final String brandName;
  final String brandId;
  const AllBrandMenuBtn({
    super.key,
    required this.brandName,
    required this.brandId,
  });

  @override
  State<AllBrandMenuBtn> createState() => _AllBrandMenuBtnState();
}

class _AllBrandMenuBtnState extends State<AllBrandMenuBtn> {
  final deleteController = DeleteBusinessController();
  // final updateController = UpdateBusinessController();
  bool isApiLoading = false;
  @override
  Widget build(BuildContext context) {
    final brandId = widget.brandId;
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
                  title: widget.brandName,
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return UpdateBusinessScreen(
                    //         id: brandId,
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                );
              });
        } else if (value == 'delete') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: widget.brandName,
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
                  setState(() {
                    isApiLoading = true;
                  });
                  deleteController
                      .deleteBusiness(context, brandId)
                      .whenComplete(() {
                    Navigator.pop(context);
                  });
                },
              );
            },
          );
        }
      },
    );
  }
}
