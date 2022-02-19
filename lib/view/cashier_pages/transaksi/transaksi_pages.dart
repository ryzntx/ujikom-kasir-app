import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kasir_restoran/includes/colors.dart';
import 'package:kasir_restoran/utils/services/firebase_coll_helper.dart';
import 'package:avatars/avatars.dart' as Avatars;

class TransaksiPages extends StatefulWidget {
  const TransaksiPages({Key? key}) : super(key: key);

  @override
  State<TransaksiPages> createState() => _TransaksiPagesState();
}

class _TransaksiPagesState extends State<TransaksiPages> {
  late Future<QuerySnapshot> menuList = _onRefresh();
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  final CollectionHelper _collectionHelper = CollectionHelper();
  bool checked = false;

  @override
  void initState() {
    menuList = _onRefresh();
    super.initState();
  }

  Future<QuerySnapshot> _onRefresh() async {
    //await Future.delayed(Duration(milliseconds: 1000));

    refreshkey.currentState?.show();
    final QuerySnapshot data = await _collectionHelper.loadCollection('menu');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: menuList,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 2),
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Avatars.Avatar(
                          sources: [
                            Avatars.NetworkSource(
                              document.get('foto'),
                            ),
                          ],
                          name: document.get('nama'),
                          shape: Avatars.AvatarShape(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            shapeBorder: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  document.get('nama'),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  document.get('harga'),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            child: Card(
                              margin: const EdgeInsets.only(
                                  right: 0, bottom: 0, top: 20),
                              elevation: 0,
                              color: const Color(colorPrimary),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Checkbox(value: checked, onChanged: null),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
