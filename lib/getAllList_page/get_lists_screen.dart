import 'package:flutter/material.dart';

import 'package:vendor_admin/getAllList_page/get_lists_controller.dart';
import 'package:vendor_admin/home_page/main_scaffold.dart';

class GetAllListsScreen extends StatefulWidget {
  const GetAllListsScreen({super.key});

  @override
  State<GetAllListsScreen> createState() => _GetAllListsScreenState();
}

class _GetAllListsScreenState extends State<GetAllListsScreen> {
  @override
  Widget build(BuildContext context) {
    final getAllList = GetAllListsController();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            FutureBuilder(
                future: getAllList.getAllList(context).whenComplete(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MainScaffold();
                      },
                    ),
                  );
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(child: Text("success"));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
