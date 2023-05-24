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
  @override
  void initState() {
    super.initState();
    final allBusiness = AllBusinessController();
    allBusiness.getAllBusiness(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer2<AllBusinessModel, NavBarModel>(
        builder: (context, model, navBarModel, _) {
      return Container(
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
                    "Total Businesses :  ' ${model.allBusinessCount} '",
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: model.allBusinessList.length,
              itemBuilder: (context, index) => Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: color.secondaryColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.05,
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: color.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.23,
                        child: Image.asset(
                          "assets/images/purpeech.jpg",
                          width: screenWidth * 0.23,
                          height: 100,
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
                              model.allBusinessList[index]["name"],
                              style: TextStyle(
                                color: color.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBoxHeight(
                            height: 10,
                          ),
                          Text(
                            model.allBusinessList[index]["address"],
                            style: TextStyle(
                              fontSize: 16,
                              color: color.white,
                            ),
                          ),
                        ],
                      ),
                      // This is Menu Btn for Edit and Delete
                      Expanded(
                        child: AllBusinessMenuBtn(
                          businessName:
                              "${model.allBusinessList[index]["name"]}",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
