import 'package:flutter/material.dart';

class ReportPendapatanPages extends StatefulWidget {
  ReportPendapatanPages({Key? key}) : super(key: key);

  @override
  State<ReportPendapatanPages> createState() => _ReportPendapatanPagesState();
}

class _ReportPendapatanPagesState extends State<ReportPendapatanPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Pendapatan'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
