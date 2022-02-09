import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:kasir_restoran/includes/colors.dart';
import 'package:kasir_restoran/view/admin_pages/admin.dart';
import 'package:kasir_restoran/view/admin_pages/data/meja/data_meja.dart';
import 'package:kasir_restoran/view/admin_pages/data/data_menu.dart';

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
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Cashier App',
      debugShowCheckedModeBanner: true,
      //debugShowMaterialGrid: true,
      theme: myTheme,
      home: const LoginPages(),
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
}
