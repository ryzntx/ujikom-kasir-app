import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:kasir_restoran/includes/colors.dart';
import 'package:kasir_restoran/utils/firebase_auth_status.dart';
import 'package:kasir_restoran/utils/services/firebase_auth_handler.dart';
import 'package:kasir_restoran/utils/services/firebase_auth_helper.dart';
import 'package:kasir_restoran/utils/services/page_navigator.dart';
import 'package:kasir_restoran/view/admin_pages/admin.dart';
import 'package:kasir_restoran/view/auth/register.dart';
import 'package:page_transition/page_transition.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({Key? key}) : super(key: key);

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _passwordVisible = true;
  bool _isLoading = false;

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

  showMsg(msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                child: Form(
                  key: _formKey,
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
                        validator: (email) {
                          if (email!.isEmpty) {
                            return 'Harap masukan Email';
                          }
                          _emailController.text = email;
                          return null;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          labelStyle: TextStyle(
                              color: _focusNode.hasFocus
                                  ? const Color(colorPrimary)
                                  : Colors.grey),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (password) {
                          if (password!.isEmpty) {
                            return 'Harap masukan Password';
                          }
                          _passwordController.text = password;
                          return null;
                        },
                        controller: _passwordController,
                        focusNode: _focusNode,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          labelStyle: TextStyle(
                              color: _focusNode.hasFocus
                                  ? const Color(colorPrimary)
                                  : Colors.grey),
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
                        style: ElevatedButton.styleFrom(
                          primary: const Color(colorPrimary),
                        ),
                        child: Text(_isLoading ? 'Harap tunggu...' : 'MASUK'),
                        onPressed: () {
                          setState(() {
                            _isLoading = false;
                          });
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            _login();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(PageTransition(
                                child: const RegisterPages(),
                                type: PageTransitionType.fade));
                          },
                          child: Text('Register')),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _login() async {
    {
      setState(() {
        _isLoading = true;
      });
      final status = await FirebaseAuthHelper()
          .login(email: _emailController.text, pass: _passwordController.text);
      setState(() {
        _isLoading = false;
      });
      if (status == AuthResultStatus.successful) {
        // Navigate to success screen
        pageNavigatorReplacement(context, const AdminPages());
//        Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(builder: (context) => SuccessScreen()),
//            (r) => false);
      } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
        showMsg(errorMsg);
      }
    }
  }

  _showAlertDialog(errorMsg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Login Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        });
  }
}
