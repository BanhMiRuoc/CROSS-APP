import 'package:flutter/material.dart';
import 'package:lab1/Bai1.dart';
import 'package:lab1/Bai2.dart';
import 'package:lab1/Bai3.dart';
import 'package:lab1/Bai4.dart';
import 'package:lab1/Bai5.dart';
import 'package:lab1/Bai6.dart';

void main() {

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Flutter Lab 1",
        debugShowCheckedModeBanner: false,
        home: Bai6(),
    );
  }
}