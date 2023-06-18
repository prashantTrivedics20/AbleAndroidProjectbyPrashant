import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'flutter_firebase_demo.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const flutter_firebase_demo(),
  ));
}
