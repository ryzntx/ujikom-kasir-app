import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kasir_restoran/includes/colors.dart';
import 'package:kasir_restoran/view/auth/login.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:page_transition/page_transition.dart';

class AdminPages extends StatefulWidget {
  const AdminPages({Key? key}) : super(key: key);

  @override
  State<AdminPages> createState() => _AdminPagesState();
}

class _AdminPagesState extends State<AdminPages> {
  // late MediaQueryData _queryData;

  @override
  void initState() {
    // _queryData = MediaQuery.of(context);
    super.initState();
  }

  Card card(IconData icn, String title, String route) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
        onPressed: () {
          Navigator.of(context).pushNamed(route);
          // Navigator.push(context,
          //     PageTransition(child: wg, type: PageTransitionType.fade));
        },
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 3.3,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(icn),
                const SizedBox(
                  height: 15,
                ),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column textHeader(String title) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(backgroundPrimary),
      // appBar: AppBar(
      //   title: const Text('Beranda Admin'),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
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
                    color: Colors.black,
                  )),
            ],
            leading: MaterialButton(
              onPressed: () {},
              child: const Icon(Icons.menu),
            ),
            pinned: true,
            expandedHeight: 120.0,
            backgroundColor: Colors.white,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                "Beranda",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textHeader("Data Master"),
                    SizedBox(
                      height: 105,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          card(Icons.account_circle_rounded, "Data Admin",
                              '/data-user'),
                          card(Icons.table_view_rounded, "Data Meja",
                              '/data-meja'),
                          card(Icons.fastfood_rounded, "Data Menu",
                              '/data-menu'),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [

                    //   ],
                    // ),
                    textHeader("Laporan"),
                    SizedBox(
                      height: 105,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          card(Icons.money, "Transaksi", '/laporan-transaksi'),
                          card(Icons.monetization_on_rounded, "Pendapatan",
                              '/laporan-pendapatan'),
                          card(
                              Icons.history, "Aktifitas", '/laporan-aktifitas'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
