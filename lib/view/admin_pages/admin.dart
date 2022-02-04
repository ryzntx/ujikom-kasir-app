import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kasir_restoran/includes/colors.dart';
import 'package:kasir_restoran/view/admin_pages/data/data_meja.dart';
import 'package:kasir_restoran/view/admin_pages/data/data_menu.dart';
import 'package:kasir_restoran/view/admin_pages/data/user/data_user.dart';
import 'package:kasir_restoran/view/admin_pages/reports/report_activity.dart';
import 'package:kasir_restoran/view/admin_pages/reports/report_pendapatan.dart';
import 'package:kasir_restoran/view/admin_pages/reports/report_transaksi.dart';
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

  Card card(IconData icn, String title, Widget wg) {
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
          Navigator.push(context,
              PageTransition(child: wg, type: PageTransitionType.fade));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 3.5,
          padding: EdgeInsets.all(20),
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
    );
  }

  Column textHeader(String title) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundPrimary),
      // appBar: AppBar(
      //   title: const Text('Beranda Admin'),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: MaterialButton(
              onPressed: () {},
              child: Icon(Icons.menu),
            ),
            pinned: true,
            expandedHeight: 120.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Beranda",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textHeader("Data Master"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        card(Icons.account_circle_rounded, "Data Admin",
                            DataUserPages()),
                        card(Icons.table_view_rounded, "Data Meja",
                            DataMejaPages()),
                        card(Icons.fastfood_rounded, "Data Menu",
                            DataMenuPages()),
                      ],
                    ),
                    textHeader("Laporan"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        card(Icons.money, "Transaksi", ReportTransaksiPages()),
                        card(Icons.monetization_on_rounded, "Pendapatan",
                            ReportPendapatanPages()),
                        card(Icons.history, "Aktifitas", ReportActivityPages()),
                      ],
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
