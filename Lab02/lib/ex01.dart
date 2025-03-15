import 'package:flutter/material.dart';

class ex01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text("Row Widget", textAlign: TextAlign.center))),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildRow(MainAxisAlignment.start, "start"),
              buildRow(MainAxisAlignment.end, "end"),
              buildRow(MainAxisAlignment.center, "center"),
              buildRow(MainAxisAlignment.spaceBetween, "spaceBetween"),
              buildRow(MainAxisAlignment.spaceEvenly, "spaceEvenly"),
              buildRow(MainAxisAlignment.spaceAround, "spaceAround"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(MainAxisAlignment alignment, String text) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: alignment,
          children: [
            buildBoxSmall(Colors.blue),
            buildBoxBig(Colors.green),
            buildBoxSmall(Colors.red),
          ],
        ),
        const SizedBox(height: 10),
        Text("MainAxisAlignment: $text",
            style: const TextStyle(fontStyle: FontStyle.italic)),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildBoxSmall(Color color) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 2),
      ),
    );
  }
  Widget buildBoxBig(Color color) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 2),
      ),
    );
  }
}
