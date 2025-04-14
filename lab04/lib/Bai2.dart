import 'package:flutter/material.dart';

class Bai2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bai2Widget(),
    );
  }
}

class Bai2Widget extends StatefulWidget {
  const Bai2Widget({super.key});

  @override
  State<Bai2Widget> createState() => _Bai2WidgetState();
}

class _Bai2WidgetState extends State<Bai2Widget> {
  int _selectedIndex = 0;
  bool _isSecretVisible = false;
  late PageController _pageController;
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
        }
      } else {
        _currentNavItems.add(_secretItem);
      }
      _isSecretVisible = !_isSecretVisible;
      _pageController.jumpToPage(_selectedIndex);
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
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _currentNavItems
          .map((item) => Center(
            child: Text(
              item['label'],
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
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