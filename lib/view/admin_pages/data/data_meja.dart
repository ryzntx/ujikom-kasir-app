import 'package:flutter/material.dart';

class DataMejaPages extends StatefulWidget {
  DataMejaPages({Key? key}) : super(key: key);

  @override
  State<DataMejaPages> createState() => _DataMejaPagesState();
}

class _DataMejaPagesState extends State<DataMejaPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Meja'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
