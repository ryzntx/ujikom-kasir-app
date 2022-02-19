import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasir_restoran/utils/services/firebase_coll_helper.dart';
import 'package:kasir_restoran/utils/services/firebase_storage_helper.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path/path.dart';

class AddMenuPages extends StatefulWidget {
  const AddMenuPages({Key? key}) : super(key: key);

  @override
  State<AddMenuPages> createState() => _AddMenuPagesState();
}

class _AddMenuPagesState extends State<AddMenuPages> {
  final TextEditingController _namaMenuController = TextEditingController();
  final TextEditingController _hargaMenuController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _picker = ImagePicker();
  bool _isLoading = false;
  File? _image;

  final menuRef =
      FirebaseFirestore.instance.collection('menu').withConverter<Menu>(
            fromFirestore: (snapshot, _) => Menu.fromJson(snapshot.data()!),
            toFirestore: (movie, _) => movie.toJson(),
          );

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImageFromCamera() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile!.path);
      print(_image?.path);
    });
  }

  Future<void> _pickImageFromGallery() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      print(_image?.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Menu'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Center(
                child: Stack(children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 100,
                      child: ClipOval(
                        child: SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: (_image == null)
                              ? null
                              : Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                          // Image.file(
                          //   _image,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: MaterialButton(
                        color: Colors.primaries[17],
                        textColor: Colors.white,
                        child: const Icon(
                          Icons.camera_alt,
                          size: 22,
                        ),
                        padding: const EdgeInsets.all(2),
                        shape: const CircleBorder(),
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            controller: ModalScrollController.of(context),
                            child: SizedBox(
                              height: 200,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: const Text("Kamera"),
                                    subtitle: const Text(
                                        "Ambil foto dari kamera anda"),
                                    leading: const Icon(Icons.camera_alt),
                                    onTap: () async {
                                      _pickImageFromCamera();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    title: const Text("Galeri"),
                                    subtitle: const Text(
                                        "Ambil foto dari galeri hp anda"),
                                    leading: const Icon(Icons.image_rounded),
                                    onTap: () async {
                                      _pickImageFromGallery();
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (namaMenu) {
                  if (namaMenu!.isEmpty) {
                    return 'Harap masukan Nama Menu';
                  }
                  _namaMenuController.text = namaMenu;
                  return null;
                },
                controller: _namaMenuController,
                decoration: InputDecoration(
                  labelText: 'Nama Menu',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (hargaMenu) {
                  if (hargaMenu!.isEmpty) {
                    return 'Harap masukan Harga Menu';
                  }
                  _hargaMenuController.text = hargaMenu;
                  return null;
                },
                controller: _hargaMenuController,
                decoration: InputDecoration(
                  labelText: 'Harga Menu',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = false;
                  });
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    addMenu().then((value) => Navigator.of(context).pop());
                  }
                },
                child: Text(_isLoading ? 'Harap Tunggu...' : 'Tambah Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addMenu() async {
    String fileName = basename(_image!.path);
    String url;
    FirebaseStorage storage = FirebaseStorage.instance;

    // melakukan fungsi
    Reference ref = storage.ref().child("/menu/$fileName");
    UploadTask uploadTask = ref.putFile(_image!);

    var dowurl =
        await (await uploadTask.whenComplete(() => ref.getDownloadURL()))
            .ref
            .getDownloadURL();
    url = dowurl.toString();

    // helper.uploadFile(_image!.path, fileName); //fungsi untuk upload file
    menuRef.add(Menu(
        nama: _namaMenuController.text,
        harga: _hargaMenuController.text,
        foto: url));

    // Bersihkan form input dan picture
    _namaMenuController.clear();
    _hargaMenuController.clear();
    setState(() {
      _image = null;
    });
  }
}
