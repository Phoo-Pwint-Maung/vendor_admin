import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/vendor_manage_page/vendor_manage_controller.dart';
import 'package:vendor_admin/vendor_manage_page/vendor_manage_model.dart';

class VendorEditScreen extends StatefulWidget {
  final String id;
  final String shopName;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String status;

  const VendorEditScreen({
    super.key,
    required this.id,
    required this.shopName,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.status,
  });

  @override
  State<VendorEditScreen> createState() => _VendorEditScreenState();
}

class _VendorEditScreenState extends State<VendorEditScreen> {
  final controller = VendorManageController();
  bool isApiWaiting = false;
  @override
  Widget build(BuildContext context) {
    final vendorModel = Provider.of<VendorManageModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color.ternaryColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
          ),
        ),
        title: const Text("Vendor Status Change"),
        backgroundColor: color.secondaryColor,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 10,
          ),
          width: screenWidth,
          child: Column(
            children: [
              // Image
              Image.asset(
                "assets/images/profile.png",
                width: screenWidth * 0.5,
              ),
              const SizedBoxHeight(
                height: 15,
              ),
              // Status
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: widget.status == "0"
                      ? color.inactiveColor
                      : color.activeColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: widget.status == "0"
                    ? Text(
                        "Inactive",
                        style: TextStyle(
                          color: color.white,
                        ),
                      )
                    : Text(
                        "Active",
                        style: TextStyle(
                          color: color.white,
                        ),
                      ),
              ),
              const SizedBoxHeight(
                height: 15,
              ),
              //  Shop Name
              Text(
                '" ${widget.shopName} "',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: color.secondaryColor,
                ),
              ),
              const SizedBoxHeight(
                height: 20,
              ),
              // Vendor Data
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name : ${widget.name}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBoxHeight(height: 15),
                  Text(
                    "Email : ${widget.email}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBoxHeight(height: 15),
                  Text(
                    "Phone : ${widget.phone}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBoxHeight(height: 15),
                  Text(
                    "Address : ${widget.address}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBoxHeight(
                height: 40,
              ),
              // Change Button
              SizedBox(
                width: screenWidth * 0.8,
                child: ElevatedButton(
                  onPressed: isApiWaiting
                      ? null
                      : () {
                          setState(() {
                            isApiWaiting = true;
                          });
                          if (widget.status == "0") {
                            vendorModel.inactiveToActive(widget.id);
                            controller
                                .inactiveToactiveFunction(context, widget.id)
                                .whenComplete(() {
                              Navigator.pop(context);
                              setState(() {
                                isApiWaiting = false;
                              });
                            });
                          } else if (widget.status == "1") {
                            vendorModel.activeToInactive(widget.id);
                            controller
                                .activeToInactiveFunction(context, widget.id)
                                .whenComplete(() {
                              Navigator.pop(context);
                            });
                          }
                        },
                  style: ButtonStyle(
                    backgroundColor: isApiWaiting
                        ? MaterialStateProperty.all<Color>(
                            color.grey,
                          )
                        : widget.status == "0"
                            ? MaterialStateProperty.all<Color>(
                                color.activeColor,
                              )
                            : MaterialStateProperty.all<Color>(
                                color.inactiveColor,
                              ),
                  ),
                  child: widget.status == "0"
                      ? const Text("Change to Active")
                      : const Text("Change to Inactive"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
