import 'package:flutter/material.dart';

class ReportTransaksiPages extends StatefulWidget {
  ReportTransaksiPages({Key? key}) : super(key: key);

  @override
  State<ReportTransaksiPages> createState() => _ReportTransaksiPagesState();
}

class _ReportTransaksiPagesState extends State<ReportTransaksiPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Transaksi'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
