import 'package:flutter/material.dart';

class ReportActivityPages extends StatefulWidget {
  ReportActivityPages({Key? key}) : super(key: key);

  @override
  State<ReportActivityPages> createState() => _ReportActivityPagesState();
}

class _ReportActivityPagesState extends State<ReportActivityPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Aktifitas'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
