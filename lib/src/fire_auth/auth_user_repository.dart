// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthUserRepository {
  String? _verId;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// send verification code by number
  Future<String> verificationNumber({required String number}) async {
    final completer = Completer<String>();
    try {
      print(number);
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          completer.complete("signedUp");
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.code);
          String error = e.code == 'invalid-phone-number'
              ? "Invalid number. Enter again."
              : "Can Not Login Now. Please try again.";
          completer.complete(error);
        },
        codeSent: (String verificationID, int? resendToken) {
          _verId = verificationID;
          print(_verId);
          completer.complete("verified");
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          completer.complete("Verification timeout error");
        },
        timeout: const Duration(seconds: 120),
      );
      return completer.future;
    } catch (e) {
      return e.toString();
    }
  }

  /// verify verification code
  Future<String> verificationCode({required String verificationCode}) async {
    final completer = Completer<String>();
    try {
      await _firebaseAuth
          .signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verId ?? "",
          smsCode: verificationCode,
        ),
      )
          .then((value) async {
        completer.complete("");
      });
      return completer.future;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}

final authUserRepository = AuthUserRepository();
