import 'dart:io';

import 'package:avatars/avatars.dart' as Avatars;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasir_restoran/utils/services/firebase_storage_helper.dart';
import 'package:kasir_restoran/view/admin_pages/data/menu/edit_menu.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path/path.dart';

import 'package:kasir_restoran/utils/services/firebase_coll_helper.dart';
import 'package:kasir_restoran/utils/services/page_navigator.dart';
import 'package:kasir_restoran/view/admin_pages/data/menu/add_menu.dart';

class DataMenuPages extends StatefulWidget {
  const DataMenuPages({Key? key}) : super(key: key);

  @override
  State<DataMenuPages> createState() => _DataMenuPagesState();
}

class _DataMenuPagesState extends State<DataMenuPages> {
  final _picker = ImagePicker();
  final CollectionHelper _collectionHelper = CollectionHelper();
  late Future<QuerySnapshot> menuList = _onRefresh();
  late String url;
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  File? _image;

  StorageHelper _storageHelper = StorageHelper(folder: 'menu');

  @override
  void initState() {
    url = "this";
    menuList = _onRefresh();
    super.initState();
  }

  Future<void> _pickImageFromCamera() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    setState(() {
      this._image = File(pickedFile!.path);
      print(_image?.path);
    });
  }

  Future<void> _pickImageFromGallery() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      this._image = File(pickedFile!.path);
      print(_image?.path);
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Menu'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          pageNavigator(context, AddMenuPages());
        },
        label: Text('TAMBAH DATA'),
        icon: Icon(Icons.add),
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
                  _storageHelper
                      .getDownloadLink(document.get('foto'))
                      .then((String result) {
                    setState(() {
                      url = result;
                    });
                  });
                  var uid = snapshot.data.docs[index].id;
                  print(url);
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0)),
                      onTap: () {
                        pageNavigator(
                            context,
                            EditMenuPages(
                                documentId: uid,
                                menuName: document.get('nama'),
                                menuPrice: document.get('harga'),
                                picUrl: url));
                      },
                      title: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Avatars.Avatar(
                              sources: [
                                Avatars.NetworkSource(url),
                              ],
                              name: document.get('nama'),
                              shape: Avatars.AvatarShape(
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
