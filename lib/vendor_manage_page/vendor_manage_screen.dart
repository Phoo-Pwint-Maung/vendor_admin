import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/vendor_manage_page/vendor_edit_screen.dart';
import 'package:vendor_admin/vendor_manage_page/vendor_list.dart';
import 'package:vendor_admin/vendor_manage_page/vendor_manage_controller.dart';
import 'package:vendor_admin/vendor_manage_page/vendor_manage_model.dart';

class VendorManageScreen extends StatefulWidget {
  const VendorManageScreen({super.key});

  @override
  State<VendorManageScreen> createState() => _VendorManageScreenState();
}

class _VendorManageScreenState extends State<VendorManageScreen> {
  final vendorManageController = VendorManageController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final model = Provider.of<VendorManageModel>(context);
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 8,
      ),
      child: Column(
        children: [
          Text("Total Vendor : ${model.apiAllVendorList.length}"),
          SizedBoxHeight(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.13,
                child: const Text(
                  "ID",
                  style: TextStyle(
                    fontSize: 18,
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
                child: const Text(
                  "Shop Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    "Status",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1.5,
            color: color.black,
          ),
          FutureBuilder(
            future: vendorManageController.getAllVendorList(context),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  controller: vendorManageController.scroll,
                  shrinkWrap: true,
                  itemCount: model.apiAllVendorList
                      .length, // Replace with your actual item count
                  itemBuilder: (context, index) {
                    return VendorList(
                      vendorId: "${index + 1}",
                      status:
                          model.apiAllVendorList[index].status.toString() == "1"
                              ? "Active"
                              : "Inactive",
                      statusColor:
                          model.apiAllVendorList[index].status.toString() == "1"
                              ? color.activeColor
                              : color.inactiveColor,
                      btnFun: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return VendorEditScreen(
                                id: model.apiAllVendorList[index].vendorId,
                                shopName:
                                    model.apiAllVendorList[index].shopName,
                                name: model.apiAllVendorList[index].name,
                                email: model.apiAllVendorList[index].email,
                                phone: model.apiAllVendorList[index].phone,
                                address: model.apiAllVendorList[index].address,
                                status: model.apiAllVendorList[index].status,
                              );
                            },
                          ),
                        );
                      },
                      shopName: model.apiAllVendorList[index].shopName,
                      email: model.apiAllVendorList[index].email,
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
