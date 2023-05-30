import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_controller.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/category_page/all_category_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';

class AllBrandScreen extends StatefulWidget {
  const AllBrandScreen({super.key});

  @override
  State<AllBrandScreen> createState() => _AllBrandScreenState();
}

class _AllBrandScreenState extends State<AllBrandScreen> {
  final controller = AllBrandController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer3<AllBrandData, NavBarModel, AllCategoryData>(
        builder: (context, model, navBarModel, categoryModel, _) {
      return SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          width: screenWidth,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Brand :  '1'",
                      style: TextStyle(
                        color: color.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: color.secondaryColor,
                        ),
                      ),
                      onPressed: () {
                        navBarModel.changePage(DrawerSection.addBrand);
                      },
                      child: Text(
                        "Add +",
                        style: TextStyle(
                          fontSize: 18,
                          color: color.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBoxHeight(
                height: 30,
              ),

              // Show List
              FutureBuilder(
                future: controller.getAllBrand(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        controller: controller.scroll,
                        itemCount: model.allBrandList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                              decoration: BoxDecoration(
                                color: color.secondaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.1,
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: color.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.2,
                                    child: Image.network(
                                      model.allBrandList[index].brandMedia,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.45,
                                        child: Text(
                                          model.allBrandList[index].brandName,
                                          style: TextStyle(
                                            color: color.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBoxHeight(
                                        height: 10,
                                      ),
                                      Text(
                                        model.allBrandList[index].categoryId,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: color.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // This is Menu Btn for Edit and Delete

                                  // Expanded(
                                  //   child: AllBrandMenuBtn(
                                  //     brandId: ,
                                  //     brandName: ,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
