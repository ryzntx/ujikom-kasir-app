import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:kasir_restoran/view/admin_pages/admin.dart';
import 'package:page_transition/page_transition.dart';

class UserManagement {
  storeNewUser(user, context) {
    FirebaseFirestore.instance
        .collection('/users')
        .add({'email': user.email, 'uid': user.uid}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          PageTransition(child: AdminPages(), type: PageTransitionType.fade));
    }).catchError((e) {
      print(e);
    });
  }
}
