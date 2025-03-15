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
  @override
  _Bai2WidgetState createState() => _Bai2WidgetState();
}

class _Bai2WidgetState extends State<Bai3Widget> {
  bool isBackPressed = false; // Kiểm tra xem đã nhấn nút back chưa
  String imageUrl = 'https://picsum.photos/250?image=1'; // Ảnh mặc định từ internet
  final List<String> internetImages = [
    'https://picsum.photos/250?image=1',
    'https://picsum.photos/250?image=2',
    'https://picsum.photos/250?image=3'
  ];
  int imageIndex = 0;

  void changeImage() {
    if (!isBackPressed) {
      setState(() {
        imageIndex = (imageIndex + 1) % internetImages.length;
        imageUrl = internetImages[imageIndex];
      });
    }
  }

  void onBackPressed() {
    setState(() {
      isBackPressed = true;
      imageUrl = 'assets/stop.jpeg'; // Ảnh local khi nhấn back
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Image Viewer'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              print('More options pressed');
            },
          ),
        ],
      ),
      body: Center(
        child: isBackPressed
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/stop.jpeg', width: 250, height: 250),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, width: 250, height: 250),
          ],
        ),
      ),
      floatingActionButton: isBackPressed
          ? FloatingActionButton(
        onPressed: null, // Vô hiệu hóa nút khi đã nhấn back
        backgroundColor: Colors.grey,
        child: const Icon(Icons.change_circle),
      )
          : FloatingActionButton(
        onPressed: changeImage,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.change_circle),
      ),
    );
  }
}