import 'package:flutter/material.dart';
import 'users.dart';

class Ex05 extends StatefulWidget {
  const Ex05({super.key});

  @override
  _Ex05 createState() => _Ex05();
}

class _Ex05 extends State<Ex05> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  List<Map<String, dynamic>> userList = users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Listview"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: userList.length,
        itemBuilder: (BuildContext context, index) {
          return buildUser(context, index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(thickness: 1, color: Colors.grey[300]);
        },
      ),
    );
  }

  Widget buildUser(BuildContext context, int index) {
    Map<String, dynamic> user = userList[index];

    return Opacity(
      opacity: user['blocked'] == true ? 0.4 : 1,
      child: ListTile(
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user['favorite'] == true)
              Icon(Icons.favorite, color: Colors.red),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (String value) {
                handleMenuSelection(value, index);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: user['favorite'] == true
                      ? 'Remove from favorite'
                      : 'Add to favorite',
                  child: ListTile(
                    leading: Icon(
                      Icons.favorite,
                      color: user['favorite'] == true
                          ? Colors.red
                          : Colors.black54,
                    ),
                    title: Text(user['favorite'] == true
                        ? 'Remove from favorite'
                        : 'Add to favorite'),
                  ),
                ),
                PopupMenuItem<String>(
                  value: user['blocked'] == true
                      ? 'Unblock this user'
                      : 'Block this user',
                  child: ListTile(
                    leading: Icon(Icons.block, color: Colors.black54),
                    title: Text(user['blocked'] == true
                        ? 'Unblock this user'
                        : 'Block this user'),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Delete this user',
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.black54),
                    title: const Text('Delete this user'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleMenuSelection(String value, int index) {
    setState(() {
      if (value == 'Add to favorite') {
        userList[index]['favorite'] = true;
      } else if (value == 'Remove from favorite') {
        userList[index]['favorite'] = false;
      } else if (value == 'Block this user') {
        userList[index]['blocked'] = true;
      } else if (value == 'Unblock this user') {
        userList[index]['blocked'] = false;
      } else if (value == 'Delete this user') {
        userList.removeAt(index);
      }
    });

    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text("$value for ${userList[index]['fullName']}"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
