import 'package:avatars/avatars.dart' as avatars;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

import 'package:kasir_restoran/utils/services/firebase_coll_helper.dart';
import 'package:kasir_restoran/utils/services/page_navigator.dart';
import 'package:kasir_restoran/view/admin_pages/data/menu/add_menu.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DataMenuPages extends StatefulWidget {
  const DataMenuPages({Key? key}) : super(key: key);

  @override
  State<DataMenuPages> createState() => _DataMenuPagesState();
}

class _DataMenuPagesState extends State<DataMenuPages> {
  final CollectionHelper _collectionHelper = CollectionHelper();
  late Future<QuerySnapshot> menuList = _onRefresh();
  late String url;
  var refreshkey = GlobalKey<RefreshIndicatorState>();

  final TextEditingController _namaMenuController = TextEditingController();
  final TextEditingController _hargaMenuController = TextEditingController();

  @override
  void initState() {
    url = "this";
    menuList = _onRefresh();
    super.initState();
  }

  Future<QuerySnapshot> _onRefresh() async {
    //await Future.delayed(Duration(milliseconds: 1000));

    refreshkey.currentState?.show();
    final QuerySnapshot data = await _collectionHelper.loadCollection('menu');
    return data;
  }

  Future<String> getUrl(String filename) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('menu')
        .child(filename);
    String url = (await ref.getDownloadURL()).toString();
    return url;
  }

  Future<void> _showBottomSheet(
      [DocumentSnapshot? documentSnapshot, String? docId]) async {
    if (documentSnapshot != null) {
      final String doc = docId!;
      _namaMenuController.text = documentSnapshot.get('nama');
      _hargaMenuController.text = documentSnapshot.get('harga');

      await showMaterialModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  top: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    avatars.Avatar(
                      sources: [
                        avatars.NetworkSource(documentSnapshot.get('foto')),
                      ],
                      name: documentSnapshot.get('nama'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: false,
                      controller: _namaMenuController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Menu',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: false,
                      controller: _hargaMenuController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Menu',
                        border: OutlineInputBorder(),
                      ),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Menu'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          pageNavigator(context, const AddMenuPages());
        },
        label: const Text('TAMBAH DATA'),
        icon: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: menuList,
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
                menuList = _onRefresh();
              });
            },
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  var doc = snapshot.data.docs[index].id;
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0)),
                      onTap: () {
                        _showBottomSheet(document, doc);
                        // pageNavigator(
                        //     context,
                        //     EditMenuPages(
                        //       documentId: uid,
                        //       menuName: document.get('nama'),
                        //       menuPrice: document.get('harga'),
                        //       picUrl: document.get('foto'),
                        //     ));
                      },
                      title: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            avatars.Avatar(
                              sources: [
                                avatars.NetworkSource(document.get('foto')),
                              ],
                              name: document.get('nama'),
                              shape: avatars.AvatarShape(
                                  width: 70,
                                  height: 70,
                                  shapeBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(document.get('nama')),
                                Text(document.get('harga'))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
