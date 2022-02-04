import 'package:flutter/material.dart';

class DataMenuPages extends StatefulWidget {
  DataMenuPages({Key? key}) : super(key: key);

  @override
  State<DataMenuPages> createState() => _DataMenuPagesState();
}

class _DataMenuPagesState extends State<DataMenuPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Menu'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
