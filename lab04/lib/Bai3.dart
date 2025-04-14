import 'package:flutter/material.dart';

class Bai3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bai3Widget(),
    );
  }
}

class Bai3Widget extends StatefulWidget {
  const Bai3Widget({super.key});

  @override
  State<Bai3Widget> createState() => _Bai3WidgetState();
}

class _Bai3WidgetState extends State<Bai3Widget> {
  int _selectedIndex = 0;
  bool _isSecretVisible = false;
  late PageController _pageController;
  List<Map<String, dynamic>>  _currentNavItems = [];

  final List<Map<String, dynamic>> _navItems = [
    {"label": "Home", "icon": Icons.home, "color": Colors.green.shade200},
    {"label": "History", "icon": Icons.history, "color": Colors.blue.shade200},
    {"label": "Contact", "icon": Icons.person, "color": Colors.yellow.shade200},
    {"label": "Settings", "icon": Icons.settings, "color": Colors.grey.shade200},
  ];

  final Map<String, dynamic> _secretItem = {
    "label": "Secret",
    "icon": Icons.security,
    "color": Colors.purple.shade200,
  };

  @override
  void initState() {
    super.initState();
    _currentNavItems = List.from(_navItems);
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _toggleSecretItem() {
    setState(() {
      if (_isSecretVisible) {
        if (_currentNavItems.length > _navItems.length) {
          _currentNavItems.removeLast();
        }
        // Return to "Home" if "Secret" was selected
        if (_selectedIndex >= _currentNavItems.length) {
          _selectedIndex = 0;
          _pageController.jumpToPage(_selectedIndex);
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
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      Navigator.of(context).pop();
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Your Name'),
              accountEmail: Text("contact@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://via.placeholder.com/150"),
              ),
            ),
            ..._currentNavItems.map((item) {
              int index = _currentNavItems.indexOf(item);
              return ListTile(
                leading: Icon(item["icon"], color: Colors.blue),
                title: Text(item["label"]),
                selected: _selectedIndex == index,
                onTap: () => _onItemTapped(index),
              );
            }).toList(),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _currentNavItems
          .map((item) => Container(
            color: item['color'],
            child: Center(
              child: Text(
                item['label'],
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _currentNavItems
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