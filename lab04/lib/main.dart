import 'package:flutter/material.dart';
import 'package:lab4/Bai1.dart';
import 'package:lab4/Bai2.dart';
import 'package:lab4/Bai3.dart';
import 'package:lab4/Bai5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bai5(),
    );
  }
}