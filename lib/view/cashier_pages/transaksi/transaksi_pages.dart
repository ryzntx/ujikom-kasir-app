import 'package:flutter/material.dart';

class TransaksiPages extends StatefulWidget {
  const TransaksiPages({Key? key}) : super(key: key);

  @override
  State<TransaksiPages> createState() => _TransaksiPagesState();
}

class _TransaksiPagesState extends State<TransaksiPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Transaksi pages'),
      ),
    );
  }
}
