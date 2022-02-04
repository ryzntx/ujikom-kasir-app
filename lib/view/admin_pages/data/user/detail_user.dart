import 'package:flutter/material.dart';

class DetailUsers extends StatefulWidget {
  DetailUsers({Key? key}) : super(key: key);

  @override
  State<DetailUsers> createState() => _DetailUsersState();
}

class _DetailUsersState extends State<DetailUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Users'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
