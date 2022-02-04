import 'package:flutter/material.dart';

import 'package:material_dialogs/material_dialogs.dart';
import 'package:select_form_field/select_form_field.dart';

class DataUserPages extends StatefulWidget {
  DataUserPages({Key? key}) : super(key: key);

  @override
  State<DataUserPages> createState() => _DataUserPagesState();
}

class _DataUserPagesState extends State<DataUserPages> {
  late String _myActivity;
  late String _myActivityResult;

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _items = [
      {
        'value': 'admin',
        'label': 'Level Admin',
        'icon': Icon(Icons.admin_panel_settings_rounded),
      },
      {
        'value': 'cashier',
        'label': 'Level Cashier',
        'icon': Icon(Icons.app_registration),
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Data User'),
        centerTitle: true,
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Dialogs.materialDialog(
            context: context,
            actions: [
              ElevatedButton(onPressed: () {}, child: Text('TAMBAHKAN!'))
            ],
            customView: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text("NAMA"),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text("EMAIL"),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text("PASSWORD"),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SelectFormField(
                    type: SelectFormFieldType.dropdown, // or can be dialog
                    initialValue: 'admin',
                    labelText: 'LEVEL',
                    items: _items,
                    // onChanged: (val) => print(val),
                    // onSaved: (val) => print(val),
                  ),
                ],
              ),
            ),
          );
        },
        label: const Text("TAMBAH DATA"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
