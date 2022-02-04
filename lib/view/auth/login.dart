import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:kasir_restoran/includes/colors.dart';
import 'package:kasir_restoran/view/admin_pages/admin.dart';
import 'package:page_transition/page_transition.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({Key? key}) : super(key: key);

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  bool _passwordVisible = true;
  late FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = FocusNode();
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(backgroundPrimary),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/icon_app.svg'),
            // const Text("Aplikasi Kasir"),
            const SizedBox(
              height: 15,
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Masuk",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Anda harus masuk terlebih dahulu sebelum mulai.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        labelStyle: TextStyle(
                            color: _focusNode.hasFocus
                                ? const Color(colorPrimary)
                                : Colors.grey),

                        // focusedBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   borderSide: const BorderSide(
                        //       color: Color(colorPrimary), width: 2),
                        // ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      focusNode: _focusNode,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        labelStyle: TextStyle(
                            color: _focusNode.hasFocus
                                ? const Color(colorPrimary)
                                : Colors.grey),
                        // focusedBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   borderSide: const BorderSide(
                        //       color: Color(colorPrimary), width: 2),
                        // ),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: const AdminPages(),
                                type: PageTransitionType.fade));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(colorPrimary),
                      ),
                      child: const Text('MASUK'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
