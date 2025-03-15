import 'package:flutter/material.dart';
import 'users.dart';
class Ex02 extends StatefulWidget {
  const Ex02({super.key});

  @override
  _Ex02 createState() => _Ex02();
}
class _Ex02 extends State<Ex02> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Listview"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, index) {
          return buildUser(context, users[index]); // Pass context for Snackbar
        },
      ),
    );
  }
  Widget buildUser(BuildContext context, Map<String, dynamic> user) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/${user['id']}.jpg")
      ),
      title: Text(
      user['fullName'],
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
      subtitle: Text(
        user['jobTitle'],
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
    ),
      trailing: Icon(Icons.more_vert),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You've clicked on ${user['fullName']}"),
            duration: Duration(seconds: 2),
          )
        );
      },
    );
  }

}