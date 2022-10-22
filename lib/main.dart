import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/ui/auth/main_auth_screen.dart';
import 'package:zet_fire/src/ui/main/main_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('id') ?? '';
  runApp(
    MyApp(
      id: id,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String id;

  const MyApp({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: id.isEmpty ? const MainAuthScreen() : const MainScreen(),
    );
  }
}
