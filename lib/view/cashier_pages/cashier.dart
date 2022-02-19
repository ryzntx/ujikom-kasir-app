import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kasir_restoran/view/auth/login.dart';
import 'package:kasir_restoran/view/cashier_pages/riwayat/riwayat_pages.dart';
import 'package:kasir_restoran/view/cashier_pages/transaksi/transaksi_pages.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class KasirPages extends StatefulWidget {
  const KasirPages({Key? key}) : super(key: key);

  @override
  State<KasirPages> createState() => _KasirPagesState();
}

class _KasirPagesState extends State<KasirPages>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Dialogs.materialDialog(
                  context: context,
                  title: 'Keluar',
                  msg: 'Yakin untuk logout?',
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Tidak')),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut().then((value) {
                            Navigator.of(context).pushReplacement(
                                PageTransition(
                                    child: const LoginPages(),
                                    type: PageTransitionType.fade));
                          }).catchError((e) {
                            print(e);
                          });
                        },
                        child: const Text('Ya'))
                  ],
                );
              },
              icon: const Icon(
                Icons.logout,
              )),
        ],
        bottom: TabBar(
            controller: tabController,
            //indicatorColor: Colors.white,
            //indicatorSize: TabBarIndicatorSize.label,
            indicator: MaterialIndicator(
              color: Colors.white,
              height: 5,
              topLeftRadius: 8,
              topRightRadius: 8,
              horizontalPadding: 50,
              tabPosition: TabPosition.bottom,
            ),
            tabs: const <Widget>[
              Tab(
                text: 'Menu',
              ),
              Tab(
                text: 'Riwayat',
              )
            ]),
      ),
      body: TabBarView(
        controller: tabController,
        children: const <Widget>[TransaksiPages(), RiwayatTransaksiPages()],
      ),
    );
  }
}
