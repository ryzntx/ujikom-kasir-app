import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:kasir_restoran/utils/services/firebase_coll_helper.dart';
import 'package:kasir_restoran/utils/services/page_navigator.dart';

class PageRoute {
  final CollectionHelper _collectionHelper = CollectionHelper();
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  checkRole(BuildContext context) async {
    QuerySnapshot data = await _collectionHelper.loadCollWhereEqual(
        'users', 'uid', auth.currentUser?.uid.toString());
    if (data.docs.first.get('role') == 'admin') {
      routeNavigatorReplacement(context, '/admin');
    } else {
      routeNavigatorRemoveUntil(context, '/kasir');
    }
  }
}
