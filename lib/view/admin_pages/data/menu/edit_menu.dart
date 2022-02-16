import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EditMenuPages extends StatefulWidget {
  const EditMenuPages(
      {Key? key,
      required this.documentId,
      required this.menuName,
      required this.menuPrice,
      required this.picUrl})
      : super(key: key);

  final String documentId;
  final String menuName;
  final String menuPrice;
  final String picUrl;

  @override
  State<EditMenuPages> createState() => _EditMenuPagesState();
}

class _EditMenuPagesState extends State<EditMenuPages> {
  late String docId;
  late String urlPic;
  final TextEditingController menuNameController = TextEditingController();
  final TextEditingController menuPriceController = TextEditingController();

  final _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    docId = widget.documentId;
    urlPic = widget.picUrl;
    menuNameController.text = widget.menuName;
    menuPriceController.text = widget.menuPrice;
    print(urlPic);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Menu'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
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
                          offset: Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 100,
                    child: ClipOval(
                      child: new SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: (_image == null)
                            ? null
                            : Image.file(
                                _image!,
                                fit: BoxFit.fill,
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
                  child: Container(
                    height: 40,
                    width: 40,
                    child: MaterialButton(
                      color: Colors.primaries[17],
                      textColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        size: 22,
                      ),
                      padding: EdgeInsets.all(2),
                      shape: CircleBorder(),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          controller: ModalScrollController.of(context),
                          child: Container(
                            height: 200,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text("Kamera"),
                                  subtitle: Text("Ambil foto dari kamera anda"),
                                  leading: Icon(Icons.camera_alt),
                                  onTap: () async {
                                    _pickImageFromCamera();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  title: Text("Galeri"),
                                  subtitle:
                                      Text("Ambil foto dari galeri hp anda"),
                                  leading: Icon(Icons.image_rounded),
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
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: menuNameController,
              decoration: InputDecoration(
                labelText: 'Nama Menu',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: menuPriceController,
              decoration: InputDecoration(
                labelText: 'Harga Menu',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Tambah Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
