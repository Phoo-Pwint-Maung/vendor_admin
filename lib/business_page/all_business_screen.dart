import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/business_page/all_business_controller.dart';
import 'package:vendor_admin/business_page/all_business_menuBtn.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';
import 'package:vendor_admin/custom_config/ui/sizedbox_height.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';

class AllBusinessScreen extends StatefulWidget {
  const AllBusinessScreen({super.key});

  @override
  State<AllBusinessScreen> createState() => _AllBusinessScreenState();
}

class _AllBusinessScreenState extends State<AllBusinessScreen> {
  final allBusiness = AllBusinessController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer2<AllBusinessData, NavBarModel>(
        builder: (context, model, navBarModel, _) {
      return SingleChildScrollView(
        controller: allBusiness.scroll,
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
                      "Total Businesses :  ' ${model.allBusinessList.length} '",
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
                        navBarModel.changePage(DrawerSection.addBusiness);
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

              ListView.builder(
                shrinkWrap: true,
                controller: allBusiness.scroll,
                itemCount: model.allBusinessList.length,
                itemBuilder: (context, index) => Card(
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
                            model.allBusinessList[index].mediaUrl,
                            width: screenWidth * 0.23,
                            height: 80,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.45,
                              child: Text(
                                model.allBusinessList[index].name,
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
                              model.allBusinessList[index].address,
                              style: TextStyle(
                                fontSize: 14,
                                color: color.white,
                              ),
                            ),
                          ],
                        ),
                        // This is Menu Btn for Edit and Delete

                        Expanded(
                          child: AllBusinessMenuBtn(
                            businessId: model.allBusinessList[index].businessId,
                            businessName: model.allBusinessList[index].name,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
