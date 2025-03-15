import 'package:flutter/material.dart';

class Bai4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BaseConverterScreen(),
    );
  }
}

class BaseConverterScreen extends StatefulWidget {
  @override
  _BaseConverterScreenState createState() => _BaseConverterScreenState();
}

class _BaseConverterScreenState extends State<BaseConverterScreen> {
  String binary = "Binary";
  String hexadecimal = "Hexadecimal";
  String octal = "Octal";

  void _convertNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        binary = "Binary";
        hexadecimal = "Hexadecimal";
        octal = "Octal";
      });
      return;
    }
    int? decimalValue = int.tryParse(value);
    if (decimalValue != null) {
      setState(() {
        binary = decimalValue.toRadixString(2);
        hexadecimal = "0x${decimalValue.toRadixString(16).toUpperCase()}";
        octal = decimalValue.toRadixString(8);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Number Base Converter",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Decimal",
                border: OutlineInputBorder(),
              ),
              onChanged: _convertNumber,
            ),
            SizedBox(height: 20),
            Text(
                binary,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                )
            ),
            Text(
                hexadecimal,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                )
            ),
            Text(
                octal,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                )
            ),
          ],
        ),
      ),
    );
  }
}