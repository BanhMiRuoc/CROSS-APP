import 'package:flutter/material.dart';

class Bai6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bai6Widget(),
    );
  }
}

class Bai6Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildRow("Align Start", MainAxisAlignment.start),
            _buildRow("Align Center", MainAxisAlignment.center),
            _buildRow("Align End", MainAxisAlignment.end),
            _buildRow("Align Space Around", MainAxisAlignment.spaceAround),
            _buildRow("Align Space Between", MainAxisAlignment.spaceBetween),
            _buildRow("Align Space Evenly", MainAxisAlignment.spaceEvenly),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, MainAxisAlignment aligment) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: aligment,
            children: List.generate(3, (index) => _buildStarIcon()),
          ),
        ),
      ],
    );
  }

  Widget _buildStarIcon() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Icon(
          Icons.star,
          color: Colors.white,
          size: 30
      ),
    );
  }
}

