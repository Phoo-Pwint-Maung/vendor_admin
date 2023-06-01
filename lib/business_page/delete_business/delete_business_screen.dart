import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/business_page/delete_business/delete_business_controller.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';

class DeleteBusinessScreen extends StatefulWidget {
  final String businessId;
  const DeleteBusinessScreen({
    super.key,
    required this.businessId,
  });

  @override
  State<DeleteBusinessScreen> createState() => _DeleteBusinessScreenState();
}

class _DeleteBusinessScreenState extends State<DeleteBusinessScreen> {
  bool isApiLoading = false;
  final controller = DeleteBusinessController();
  late int index;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final model = Provider.of<AllBusinessData>(context);
    index = controller.selectedItemIndex(data: model, id: widget.businessId);

    return SafeArea(
      child: Scaffold(
        backgroundColor: color.ternaryColor,
        appBar: AppBar(
          backgroundColor: color.secondaryColor,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
            ),
          ),
        ),
        body: Container(
          width: screenWidth,
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Column(
            children: [
              const Text(
                "Comfirm Deleting Here",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBoxHeight(
                height: 50,
              ),
              Image.network(
                model.allBusinessList[index].mediaUrl,
                width: screenWidth * 0.5,
              ),
              const SizedBoxHeight(
                height: 30,
              ),
              Text(
                model.allBusinessList[index].name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color.secondaryColor,
                ),
              ),
              Text(
                model.allBusinessList[index].address,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBoxHeight(
                height: 50,
              ),
              ElevatedButton(
                style: isApiLoading
                    ? ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          color.grey,
                        ),
                      )
                    : ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          color.red,
                        ),
                      ),
                onPressed: isApiLoading
                    ? null
                    : () {
                        setState(() {
                          isApiLoading = true;
                        });
                        controller
                            .deleteBusiness(context,
                                model.allBusinessList[index].businessId)
                            .whenComplete(
                          () {
                            setState(() {
                              isApiLoading = false;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
