import 'package:flutter/material.dart';

import 'package:lab02/ex01.dart';
import 'package:lab02/ex02.dart';
import 'package:lab02/ex03.dart';
import 'package:lab02/ex04.dart';
import 'package:lab02/ex05.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lab 02',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: ex05(),
    );
  }
}
