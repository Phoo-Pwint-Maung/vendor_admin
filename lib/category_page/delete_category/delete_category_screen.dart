import 'package:flutter/material.dart';
import 'package:vendor_admin/category_page/delete_category/delete_category_controller.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';

class DeleteCategoryScreen extends StatefulWidget {
  final String name;
  final String url;
  final String categoryId;
  const DeleteCategoryScreen({
    super.key,
    required this.name,
    required this.url,
    required this.categoryId,
  });

  @override
  State<DeleteCategoryScreen> createState() => _DeleteCategoryScreenState();
}

class _DeleteCategoryScreenState extends State<DeleteCategoryScreen> {
  final controller = DeleteCategoryController();
  bool isApiLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                widget.url,
                width: screenWidth * 0.5,
              ),
              const SizedBoxHeight(
                height: 30,
              ),
              Text(
                widget.name,
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
                            .deleteBusiness(context, widget.categoryId)
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
