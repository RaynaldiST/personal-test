import 'package:flutter/material.dart';
import 'package:test_project/constant/util.dart';

class ContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Contact",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: Util.baseTextSize18,
          ),
        ),
      ),
    );
  }
}
