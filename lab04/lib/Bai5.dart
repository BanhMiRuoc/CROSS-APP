import 'package:flutter/material.dart';

class Bai5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bai5Widget(),
    );
  }
}

class Bai5Widget extends StatefulWidget {
  const Bai5Widget({super.key});

  @override
  State<Bai5Widget> createState() => _Bai5WidgetState();
}

class _Bai5WidgetState extends State<Bai5Widget> with SingleTickerProviderStateMixin{
  int _selectedIndex = 0;
  bool _isSecretVisible = false;
  late TabController _tabController;
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
    _tabController = TabController(length: _currentNavItems.length, vsync: this);
    _tabController.addListener(_syncWithTabBar);
  }

  @override
  void dispose() {
    _tabController.removeListener(_syncWithTabBar);
    _tabController.dispose();
    super.dispose();
  }

  void _syncWithTabBar() {
    if (_tabController.index != _selectedIndex) {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    }
  }

  void _toggleSecretItem() {
    setState(() {
      if (_isSecretVisible) {
        if (_currentNavItems.length > _navItems.length) {
          _currentNavItems.removeLast();
        }
        if (_selectedIndex >= _currentNavItems.length) {
          _selectedIndex = 0;
        }
      } else {
        _currentNavItems.add(_secretItem);
      }
      _isSecretVisible = !_isSecretVisible;
      _tabController = TabController(length: _currentNavItems.length, vsync: this, initialIndex: _selectedIndex);
      _tabController.addListener(_syncWithTabBar);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navbar + TabBar'),
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
        bottom: TabBar(
          controller: _tabController,
          tabs: _currentNavItems.map((item) => Tab(text: item["label"])).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _currentNavItems.map((item) {
          return Center(
            child: Text(
              item["label"],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
               ),
            ),
          );
        }).toList(),
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