import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final GoogleSignIn _gSI = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/cloud-platform.read-only',
    ],
  );

  Future<String> handleSignIn() async {
    String email = '';
    try {
      GoogleSignInAccount? data = await _gSI.signIn();
      if (data != null) {
        email = data.email;
      }
    } catch (e) {
      print(e);
    }
    return email;
  }
}

final authRepo = AuthRepo();
