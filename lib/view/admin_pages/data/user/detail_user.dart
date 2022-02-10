import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class DetailUsersPages extends StatefulWidget {
  const DetailUsersPages(
      {Key? key,
      required this.documentId,
      required this.email,
      required this.role,
      required this.displayName})
      : super(key: key);
  final String documentId;
  final String email;
  final String role;
  final String displayName;

  @override
  State<DetailUsersPages> createState() => _DetailUsersPagesState();
}

class _DetailUsersPagesState extends State<DetailUsersPages> {
  late String docid; // Variable untuk id document

  // Text Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  //Initialize FirebaseFirestore Collection
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    //Initialize TextEditingController
    _emailController.text = widget.email;
    _displayNameController.text = widget.displayName;
    _roleController.text = widget.role;

    docid = widget.documentId;
    print('@DocId: $docid');
    super.initState();
  }

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'admin',
      'label': 'Level Admin',
      'icon': Icon(Icons.admin_panel_settings_rounded),
    },
    {
      'value': 'kasir',
      'label': 'Level Kasir',
      'icon': Icon(Icons.app_registration),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.delete))],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _displayNameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SelectFormField(
              controller: _roleController,
              type: SelectFormFieldType.dropdown, // or can be dialog
              // initialValue: _roleController.text,
              labelText: 'LEVEL',
              items: _items,
              // onChanged: (val) => print(val),
              // onSaved: (val) => print(val),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _collectionReference.doc(docid).update({
                    'displayName': _displayNameController.text,
                    'email': _emailController.text,
                    'role': _roleController.text
                  });
                },
                child: const Text('UPDATE DATA'))
          ],
        ),
      ),
    );
  }
}
