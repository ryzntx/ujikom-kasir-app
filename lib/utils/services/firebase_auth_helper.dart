import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:kasir_restoran/utils/firebase_auth_status.dart';

import 'firebase_auth_handler.dart';

class FirebaseAuthHelper {
  final _auth = FirebaseAuth.instance;
  AuthResultStatus? _status;

  ///
  /// Helper Functions
  ///
  Future<AuthResultStatus?> createAccount({name, email, pass, context}) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (authResult.user != null) {
        authResult.user!.updateDisplayName(name);
        // FirebaseFirestore.instance.collection('/users').add({
        //   'email': authResult.user!.email,
        //   'uid': authResult.user!.uid,
        //   'role': 'kasir'
        // });
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
      // } on FirebaseAuthException catch (e) {
      //   print(e);
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus?> login({email, pass}) async {
    try {
      final authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);

      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  logout() {
    _auth.signOut();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FirebaseAuthHelper && other._status == _status;
  }

  @override
  int get hashCode => _status.hashCode;
}
