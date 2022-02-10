import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DataMenuPages extends StatefulWidget {
  const DataMenuPages({Key? key}) : super(key: key);

  @override
  State<DataMenuPages> createState() => _DataMenuPagesState();
}

class _DataMenuPagesState extends State<DataMenuPages> {
  showBottomSheets() {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) {
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Menu'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('TAMBAH DATA'),
        icon: Icon(Icons.add),
      ),
      body: Container(),
    );
  }
}
