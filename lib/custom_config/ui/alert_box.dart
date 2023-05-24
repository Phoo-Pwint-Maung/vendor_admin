import 'package:flutter/material.dart';
import 'package:vendor_admin/custom_config/ui/add_brand_component.dart';

class AlertBox extends StatefulWidget {
  final String title;
  final String content;
  final String firstBtnName;
  final String secondBtnName;
  final Color? contentColor;
  final Color? firstBtnColor;
  final Color? secondBtnColor;
  final Color? backgroundColor;

  const AlertBox({
    super.key,
    required this.title,
    required this.content,
    required this.firstBtnName,
    required this.secondBtnName,
    required this.contentColor,
    required this.firstBtnColor,
    required this.secondBtnColor,
    required this.backgroundColor,
  });

  @override
  State<AlertBox> createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.backgroundColor,
      title: Text(
        '" ${widget.title} "',
        style: TextStyle(
          color: color.primaryColor,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        widget.content,
        style: TextStyle(
          color: widget.contentColor,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            widget.firstBtnName,
            style: TextStyle(
              fontSize: 16,
              color: widget.firstBtnColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            widget.secondBtnName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: widget.secondBtnColor,
            ),
          ),
        )
      ],
    );
  }
}
