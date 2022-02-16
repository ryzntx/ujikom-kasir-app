import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:kasir_restoran/includes/colors.dart';
import 'package:kasir_restoran/utils/services/firebase_coll_helper.dart';
import 'package:kasir_restoran/view/admin_pages/admin.dart';
import 'package:kasir_restoran/view/admin_pages/data/meja/data_meja.dart';
import 'package:kasir_restoran/view/admin_pages/data/menu/data_menu.dart';

import 'package:kasir_restoran/view/admin_pages/data/user/data_user.dart';
import 'package:kasir_restoran/view/admin_pages/reports/report_activity.dart';
import 'package:kasir_restoran/view/admin_pages/reports/report_pendapatan.dart';
import 'package:kasir_restoran/view/admin_pages/reports/report_transaksi.dart';
import 'package:kasir_restoran/view/cashier_pages/cashier.dart';

import 'firebase_options.dart';
import 'view/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'My Cashier App',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FirebaseCrashlytics.instance.crash();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final CollectionHelper _collectionHelper = CollectionHelper();
  final auth = FirebaseAuth.instance;
  String initial = '/login';
  // String routes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Cashier App',
      debugShowCheckedModeBanner: true,
      //debugShowMaterialGrid: true,
      theme: myTheme,
      home: const LoginPages(),
      // initialRoute: _route().then((String route) {
      //   return routes;
      // }),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/admin',

      routes: <String, WidgetBuilder>{
        "/login": (context) => const LoginPages(),
        "/admin": (context) => const AdminPages(),
        "/kasir": (context) => const KasirPages(),
        "/data-user": (context) => const DataUserPages(),
        "/data-meja": (context) => const DataMejaPages(),
        "/data-menu": (context) => const DataMenuPages(),
        "/laporan-transaksi": (context) => ReportTransaksiPages(),
        '/laporan-pendapatan': (context) => ReportPendapatanPages(),
        '/laporan-aktifitas': (context) => ReportActivityPages(),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  Future<String> _route() async {
    QuerySnapshot data = await _collectionHelper.loadCollWhereEqual(
        'users', 'uid', auth.currentUser?.uid.toString());
    if (FirebaseAuth.instance.currentUser != null) {
      if (data.docs.first.get('role') == 'admin') {
        initial = '/admin';
      } else if (data.docs.first.get('role') == 'admin') {
        initial = '/kasir';
      }
    } else {
      initial = '/login';
    }
    return initial;
  }
}
