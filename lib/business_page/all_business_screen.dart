import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/business_page/all_business_model.dart';

class AllBusinessScreen extends StatefulWidget {
  const AllBusinessScreen({super.key});

  @override
  State<AllBusinessScreen> createState() => _AllBusinessScreenState();
}

class _AllBusinessScreenState extends State<AllBusinessScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final model = Provider.of<AllBusinessModel>(context);
    return Container(
      width: screenWidth,
      child: Column(
        children: [
          Text("Business Count ${model.allBusinessCount}"),
          ListView.builder(
            shrinkWrap: true,
            itemCount: model.allBusinessList.length,
            itemBuilder: (context, index) => Card(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("$index"),
                    Image.asset(
                      "assets/images/purpeech.jpg",
                      width: screenWidth * 0.25,
                      height: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.allBusinessList[index]["name"]),
                        Text(model.allBusinessList[index]["address"]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
