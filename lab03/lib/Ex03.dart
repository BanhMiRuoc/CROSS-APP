import 'package:flutter/material.dart';
import 'users.dart';

class Ex03 extends StatefulWidget {
  const Ex03({super.key});

  @override
  _Ex03 createState() => _Ex03();
}

class _Ex03 extends State<Ex03> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Listview"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: users.length,
        itemBuilder: (BuildContext context, index) {
          return buildUser(context, users[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(thickness: 1, color: Colors.grey[300]);
        },
      ),
    );
  }

  Widget buildUser(BuildContext context, Map<String, dynamic> user) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(
            "https://randomuser.me/api/portraits/men/${user['id']}.jpg"),
      ),
      title: Text(
        user['fullName'],
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        user['jobTitle'],
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
      trailing: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (String value) {
          _scaffoldKey.currentState?.showSnackBar(
            SnackBar(
              content: Text("$value for ${user['fullName']}"),
              duration: Duration(seconds: 2),
            ),
          );
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Add to favorite',
            child: ListTile(
              leading: Icon(Icons.favorite, color: Colors.black54),
              title: Text('Add to favorite'),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Block this user',
            child: ListTile(
              leading: Icon(Icons.block, color: Colors.black54),
              title: Text('Block this user'),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Delete this user',
            child: ListTile(
              leading: Icon(Icons.delete, color: Colors.black54),
              title: Text('Delete this user'),
            ),
          ),
        ],
      ),
      onTap: () {
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text("You've clicked on ${user['fullName']}"),
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }
}
