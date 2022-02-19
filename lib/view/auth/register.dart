import 'package:flutter/material.dart';
import 'package:kasir_restoran/includes/colors.dart';
import 'package:kasir_restoran/utils/firebase_auth_status.dart';
import 'package:kasir_restoran/utils/services/firebase_auth_handler.dart';
import 'package:kasir_restoran/utils/services/firebase_auth_helper.dart';
import 'package:kasir_restoran/utils/services/page_navigator.dart';
import 'package:kasir_restoran/view/admin_pages/admin.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({Key? key}) : super(key: key);

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _passwordVisible = true;
  bool _isLoading = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                validator: (nama) {
                  if (nama!.isEmpty) {
                    return 'Harap masukan nama';
                  }
                  _namaController.text = nama;
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
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
                decoration: const InputDecoration(
                  label: Text('Email'),
                  border: OutlineInputBorder(),
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
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  label: const Text('Password'),
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
                child: Text(_isLoading ? 'Harap tunggu...' : 'Daftar!'),
                onPressed: () async {
                  setState(() {
                    _isLoading = false;
                  });
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    _createAccount();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _createAccount() async {
    try {
      final status = await FirebaseAuthHelper().createAccount(
          name: _namaController.text,
          email: _emailController.text,
          pass: _passwordController.text);
      //   .then((signedInUser) {
      // UserManagement().storeNewUser(signedInUser, context);
      setState(() {
        _isLoading = false;
      });
      if (status == AuthResultStatus.successful) {
        pageNavigatorReplacement(context, const AdminPages());
      } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
        showMsg(errorMsg);
      }
    } catch (e) {
      showMsg(e.toString());
    }
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

  _showAlertDialog(errorMsg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Register Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        });
  }
}
