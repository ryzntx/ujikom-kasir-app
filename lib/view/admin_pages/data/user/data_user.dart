import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kasir_restoran/view/admin_pages/data/user/detail_user.dart';

import 'package:material_dialogs/material_dialogs.dart';
import 'package:page_transition/page_transition.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DataUserPages extends StatefulWidget {
  const DataUserPages({Key? key}) : super(key: key);

  @override
  State<DataUserPages> createState() => _DataUserPagesState();
}

class _DataUserPagesState extends State<DataUserPages> {
  bool _passwordVisible = true;

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  late Future<QuerySnapshot> usersList = _onRefresh();

  //Text Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  // final TextEditingController _emailController = new TextEditingController();

  var refreshkey = GlobalKey<RefreshIndicatorState>();

  Future<QuerySnapshot> _onRefresh() async {
    // await Future.delayed(Duration(milliseconds: 10000));

    refreshkey.currentState?.show();
    final QuerySnapshot data = await db.collection('users').get();
    return data;
  }

  @override
  void initState() {
    print(auth.currentUser!.uid);
    // TODO: implement initState
    _passwordVisible = false;
    usersList = _onRefresh();

    super.initState();
  }

  Future<void> _showBottomSheet(
      [DocumentSnapshot? documentSnapshot, String? docId]) async {
    if (documentSnapshot != null) {
      final String doc = docId!;
      final String uid = documentSnapshot['uid'];
      _emailController.text = documentSnapshot['email'];
      _displayNameController.text = documentSnapshot['displayName'];
      _roleController.text = documentSnapshot['role'];

      await showMaterialModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  top: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Container(
                height: 300,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: false,
                      controller: _displayNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: false,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: false,
                      controller: _roleController,
                      decoration: const InputDecoration(
                        labelText: 'Level',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    OutlineButton(
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                            child: DetailUsersPages(
                              role: _roleController.text,
                              displayName: _displayNameController.text,
                              email: _emailController.text,
                              documentId: doc,
                            ),
                            type: PageTransitionType.fade));
                      },
                      child: const Text('EDIT'),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      await showModalBottomSheet(
          context: context,
          builder: (BuildContext ctx) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
    }
  }

  Future loadCollection() async {
    return await db
        .collection("users")
        // .where('uid', isEqualTo: auth.currentUser!.uid)
        .get();
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
      body: FutureBuilder(
        future: usersList,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            key: refreshkey,
            onRefresh: () async {
              setState(() {
                usersList = _onRefresh();
              });
            },
            child: ListView.builder(
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                var uid = snapshot.data.docs[index].id;
                return Card(
                  margin: const EdgeInsets.all(5),
                  child: MaterialButton(
                    padding: const EdgeInsets.all(15),
                    onPressed: () {
                      _showBottomSheet(document, uid);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(document['displayName']),
                              Text(document['email']),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Hak Akses'),
                              Text(document.get('role')),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.docs.length,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Dialogs.materialDialog(
            context: context,
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
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    // focusNode: _focusNode,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      // labelStyle: TextStyle(
                      //     color: _focusNode.hasFocus
                      //         ? const Color(colorPrimary)
                      //         : Colors.grey),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          print(_passwordVisible);
                          setState(
                            () {
                              _passwordVisible = !_passwordVisible;
                            },
                          );
                        },
                      ),
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
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('TAMBAHKAN!'))
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
