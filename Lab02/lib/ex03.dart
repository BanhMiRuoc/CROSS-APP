
import 'package:flutter/material.dart';

class ex03 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/cat.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                "Mai Nguyen Phuong Trang",
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "FLUTTER DEVELOPER",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              Divider(
                color: Colors.white54,
                thickness: 1,
                indent: 50,
                endIndent: 50,
              ),

              SizedBox(height: 20),

              InfoCard(icon: Icons.phone, text: "+84 129 992 229"),
              InfoCard(icon: Icons.email, text: "bmr@gmail.com"),
              InfoCard(icon: Icons.web, text: "facebook/bmr"),
            ],
          )
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  InfoCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: ListTile(
        leading: Icon(icon, color:Colors.teal),
        title: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}