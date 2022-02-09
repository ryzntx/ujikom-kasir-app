import 'package:flutter/material.dart';

class DataMejaPages extends StatefulWidget {
  const DataMejaPages({Key? key}) : super(key: key);

  @override
  State<DataMejaPages> createState() => _DataMejaPagesState();
}

class _DataMejaPagesState extends State<DataMejaPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Meja'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('TAMBAH DATA'),
          icon: const Icon(Icons.add)),
      body: ListView(
        children: [
          Text('helo'),
        ],
      ),
    );
  }
}
