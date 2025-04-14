import 'package:flutter/material.dart';

class Bai1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bai1Widget(),
    );
  }
}

class Bai1Widget extends StatefulWidget {
  const Bai1Widget({super.key});

  @override
  State<Bai1Widget> createState() => _Bai1WidgetState();
}

class _Bai1WidgetState extends State<Bai1Widget> {
  int _selectedIndex = 0;
  bool _isSecretVisible = false;
  List<Map<String, dynamic>>  _currentNavItems = [];

  List<Map<String, dynamic>> _navItems = [
    {"label": "Home", "icon": Icons.home},
    {"label": "History", "icon": Icons.history},
    {"label": "Contact", "icon": Icons.person},
    {"label": "Settings", "icon": Icons.settings},
  ];

  Map<String, dynamic> _secretItem = {
    "label": "Secret",
    "icon": Icons.security,
  };

  @override
  void initState() {
    super.initState();
    _currentNavItems = List.from(_navItems);
  }

  void _toggleSecretItem() {
    setState(() {
      if (_isSecretVisible) {
        if (_currentNavItems.length > _navItems.length) {
          _currentNavItems.removeLast();
        }
        if (_selectedIndex >= _currentNavItems.length) {
          _selectedIndex = _currentNavItems.length - 1;
        }
      } else {
        _currentNavItems.add(_secretItem);
      }
      _isSecretVisible = !_isSecretVisible;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> navItems = List.from(_navItems);
    if (_isSecretVisible) {
      navItems.add(_secretItem);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navbar'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        actions: <Widget> [
          IconButton(
            icon: Icon(
              _isSecretVisible
                  ? Icons.lock_open
                  : Icons.lock,
            ),
            onPressed: _toggleSecretItem,
          ),
        ],
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              navItems[_selectedIndex]["label"],
              style: TextStyle(
                  fontSize: 24
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navItems
            .map((item) => BottomNavigationBarItem(
          icon: Icon(item["icon"]),
          label: item["label"],
        )).toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}