import 'package:flutter/material.dart';

class LoggedUserPages extends StatefulWidget {
  const LoggedUserPages({Key? key}) : super(key: key);

  @override
  State<LoggedUserPages> createState() => _LoggedUserPagesState();
}

class _LoggedUserPagesState extends State<LoggedUserPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail User'),
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
