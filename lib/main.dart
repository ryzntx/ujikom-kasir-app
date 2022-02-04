import 'package:flutter/material.dart';
import 'package:kasir_restoran/includes/colors.dart';

import 'view/auth/login.dart';

void main() {
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
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
