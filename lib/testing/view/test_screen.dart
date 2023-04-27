import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:vendor_admin/testing/controller/test_controller.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final testController = TestController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Consumer<PlayLists>(builder: (context, playlist, _) {
            return SingleChildScrollView(
              controller: testController.scrollcontroller,
              child: Column(
                children: [
                  Text("Testing"),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: testController.texteditingController,
                      decoration: const InputDecoration(
                        label: Text("search"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      testController.searchPlayLists(context);
                    },
                    child: Text("Search"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("${playlist.searchText}"),
                  ...playlist.allList.map(
                    (e) => Container(
                      width: 400,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 2,
                      ),
                      color: Colors.black,
                      child: Row(
                        children: [
                          Image.network(
                            e.albumPhoto,
                            width: 80,
                            height: 100,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.songName,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    e.artistName,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
