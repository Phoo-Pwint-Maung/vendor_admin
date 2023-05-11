import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vendor_admin/api/default_api.dart';
import 'package:vendor_admin/api_test/show_test.dart';
import 'package:vendor_admin/custom_config/ui/register_components.dart';
import 'package:dio/dio.dart';

class FormTest extends StatefulWidget {
  final String pageName;
  final String btnName;
  final String function;
  final String? title;
  final String? description;
  final String? id;
  const FormTest(
      {super.key,
      required this.pageName,
      required this.btnName,
      required this.function,
      this.title,
      this.description,
      this.id});

  @override
  State<FormTest> createState() => _FormTestState();
}

class _FormTestState extends State<FormTest> {
  final dio = Dio();
  // form text
  final title = TextEditingController();
  final description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final autoFillTitle = widget.title;
    final autoFillDescription = widget.description;
    if (widget.function == "Edit" &&
        autoFillTitle != null &&
        autoFillDescription != null) {
      if (widget.title != null) {}
      title.text = autoFillTitle;
      description.text = autoFillDescription;

      print("This is title : ${autoFillTitle}");
      print(autoFillDescription);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.pageName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // RegisterFormfield(
              //   textEditingController: title,
              //   text: "title",
              //   formIcon: Icons.abc,
              // ),
              // RegisterFormfield(
              //   textEditingController: description,
              //   text: "description",
              //   formIcon: Icons.home,
              // ),
              OutlinedButton(
                onPressed: () {
                  if (widget.function == 'Add') {
                    PostApi().submitData(title, description);
                  } else if (widget.function == 'Edit') {
                    final id = widget.id;
                    if (id != null) {
                      PutApi().submitData(title, description, id);
                    }
                  }
                },
                child: Text(widget.btnName),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShowTest(),
                    ),
                  );
                },
                child: const Text("show list"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
