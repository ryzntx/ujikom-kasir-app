import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CollectionHelper {
  final collection = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future loadCollection(String collectionName) async {
    return await collection.collection(collectionName).get();
  }

  Future loadCollWhereEqual(String collectionName, fieldName, findWhat) async {
    return await collection
        .collection(collectionName)
        .where(fieldName, isEqualTo: findWhat)
        .get();
  }
}

class Menu {
  final String nama;
  final String harga;
  final String foto;

  Menu({required this.nama, required this.harga, required this.foto});

  Menu.fromJson(Map<String, Object?> json)
      : this(
          nama: json['nama']! as String,
          harga: json['harga']! as String,
          foto: json['foto']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'nama': nama,
      'harga': harga,
      'foto': foto,
    };
  }
}
