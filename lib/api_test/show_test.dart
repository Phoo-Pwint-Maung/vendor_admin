import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:dio/dio.dart';
import 'package:vendor_admin/api/default_api.dart';
import 'package:vendor_admin/api_test/form_test.dart';
import 'package:vendor_admin/custom_config/ui/style.dart';
import 'package:http/http.dart' as http;

class ShowTest extends StatefulWidget {
  const ShowTest({super.key});

  @override
  State<ShowTest> createState() => _ShowTestState();
}

class _ShowTestState extends State<ShowTest> {
  final dio = Dio();
  List items = [];

  // color
  final color = ColorConst();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
    print("here is ${items.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new_sharp),
      ),
      body: RefreshIndicator(
        onRefresh: fetchTodo,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index] as Map;
            final id = item['_id'] as String;
            return ListTile(
              leading: CircleAvatar(child: Text("${index + 1}")),
              title: Text(item['title']),
              subtitle: Text(item['description']),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  if (value == 'edit') {
                    // Open Edit Page

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormTest(
                          pageName: "Edit Page",
                          btnName: "Edit",
                          function: "Edit",
                          title: item['title'],
                          description: item['description'],
                          id: id,
                        ),
                      ),
                    );
                  } else if (value == 'delete') {
                    deleteById(id);
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Edit"),
                      value: 'edit',
                    ),
                    PopupMenuItem(
                      child: Text("Delete"),
                      value: 'delete',
                    )
                  ];
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> fetchTodo() async {
    print("here");
    String url = "https://api.nstack.in/v1/todos?page=1&limit=10";
    final Uri uri = Uri.parse(url);
    final response = await dio.get(url);
    // final response = await http.get(uri);

    print(response.data);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // final json = jsonDecode(response.data) as Map;
      final json = response.data;
      final result = json['items'] as List;

      setState(() {
        items = result;
      });
    } else {}
  }

  Future<void> deleteById(String id) async {
    // Delete the item
    final url = DeleteApi().deleteApi(id: id);
    // Remove item from the list
  }
}
