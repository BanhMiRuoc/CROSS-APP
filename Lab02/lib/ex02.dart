import 'package:flutter/material.dart';

class ex02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body:
          Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        border: Border.all(
                              width: 4,
                              color: Colors.black
                          ),
                      ),
                      child: Center(child: Text("A")),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        border: Border.all(
                            width: 4,
                            color: Colors.black
                        ),
                      ),
                      child: Center(child: Text("B")),
                    ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        border: Border.all(
                            width: 4,
                            color: Colors.black
                        ),
                      ),
                      child: Center(child: Text("C")),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(
                            width: 4,
                            color: Colors.black
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "D",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          "E",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}