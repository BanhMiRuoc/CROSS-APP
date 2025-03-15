import 'package:flutter/material.dart';

class Bai1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Bai1Widget(),
        ),
      )
    );
  }
}

class Bai1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      padding: EdgeInsets.all(8.0),
      child: const Text(
          'Hello, Flutter!',
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.red,
              fontSize: 25,
              letterSpacing: 5.0
          )
      )
    );
  }
}