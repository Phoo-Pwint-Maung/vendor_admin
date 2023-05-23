import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.getAllBrand(context);
    controller.showAllBrand(context);
  }

  @override
  Widget build(BuildContext context) {
    // width
    double screenWidth = MediaQuery.of(context).size.width;
    final brandList = Provider.of<AllBrandModel>(context, listen: false);
    final navBarModel = Provider.of<NavBarModel>(context, listen: false);

    return SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                navBarModel.changePage(DrawerSection.addBrand);
              },
              child: Text("Add Brand"),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (brandList.brandCount / 2) //brandList.brandCount
                  .ceil(), // Determine the number of rows needed
              itemBuilder: (context, rowIndex) {
                return GridView.count(
                  crossAxisCount: 2, // Number of cards per row
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.7,

                  children:
                      brandList.nameList.skip(rowIndex * 2).take(2).map((item) {
                    int index = brandList.nameList.indexOf(item);
                    final String cardId = brandList.idList[index];
                    return GestureDetector(
                      onTap: () {
                        // Get id and name of the brand card
                        brandList.chooseBrand(item, cardId);
                      },
                      child: Card(
                        color: color.secondaryColor,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/purpeech.jpg',
                              width: screenWidth * 0.2,
                              height: 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: color.primaryColor,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Get id and name of the brand card
                                brandList.chooseBrand(item, cardId);
                                navBarModel
                                    .changePage(DrawerSection.addCategory);
                                navBarModel.currentPage ==
                                        DrawerSection.addCategory
                                    ? true
                                    : false;
                                // Perform some action
                              },
                              child: Text(
                                'Add Category',
                                style: TextStyle(
                                  color: color.ternaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  TextButton(
                                    style: ButtonStyle(),
                                    onPressed: () {
                                      // Perform some action
                                    },
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: color.white,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Perform some action
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: color.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
