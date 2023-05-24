import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/brand_page/all_brand_card.dart';
import 'package:vendor_admin/brand_page/all_brand_controller.dart';
import 'package:vendor_admin/brand_page/all_brand_model.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';
import 'package:vendor_admin/navbar/navbar_model.dart';

class AllBrandScreen extends StatefulWidget {
  const AllBrandScreen({super.key});

  @override
  State<AllBrandScreen> createState() => _AllBrandScreenState();
}

class _AllBrandScreenState extends State<AllBrandScreen> {
  // color
  final color = ColorConst();
  final controller = AllBrandController();

  Future<Object?>? gettingData() async {
    await controller.getAllBrand(context);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    final brandList = Provider.of<AllBrandModel>(context, listen: false);
    final navBarModel = Provider.of<NavBarModel>(context, listen: false);

    return FutureBuilder(
        future: gettingData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Show error message if data fetching fails
          } else {
            return SingleChildScrollView(
              controller: ScrollController(),
              child: Container(
                width: screenWidth,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        navBarModel.changePage(DrawerSection.addBrand);
                      },
                      child: const Text("Add Brand"),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (brandList.allBrandList.length /
                              2) //brandList.brandCount
                          .ceil(), // Determine the number of rows needed
                      itemBuilder: (context, rowIndex) {
                        return GridView.count(
                          crossAxisCount: 2, // Number of cards per row
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 0.7,

                          children: brandList.brandNameList
                              .skip(rowIndex * 2)
                              .take(2)
                              .map((item) {
                            return GestureDetector(
                              onTap: () {},
                              // Showing Brand Cards
                              child: AllBrandCard(brandName: item),
                            );
                          }).toList(),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
