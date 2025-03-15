import 'package:flutter/material.dart';

import 'Ex01.dart';
import 'Ex02.dart';
import 'Ex03.dart';
import 'Ex04.dart';
import 'Ex05.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Ex05(),
    );
  }
}


