import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  final String folder;

  StorageHelper({required this.folder});

  Future<void> uploadFile(String filepath, filename) async {
    File file = File(filepath);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    try {
      await firebaseStorage.ref(folder + '/' + filename).putFile(file);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<String> getDownloadLink(String filename) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    String url = await firebaseStorage
        .ref()
        .child(folder)
        .child(filename)
        .getDownloadURL();
    return url;
  }
}
