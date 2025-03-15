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

class Bai2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Image Viewer'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print('Back button pressed');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              print('More button pressed');
            },
          ),
        ],
      ),
      body: const Center(
        child: ImageFromUrl(
            imageUrl:
            'https://picsum.photos/250?image=1'
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              print("Change Circle button pressed");
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.change_circle),
          ),
        ],
      ),
    );
  }
}

class ImageFromUrl extends StatelessWidget {
  final String imageUrl;

  const ImageFromUrl({super.key, required this.imageUrl});


  @override
  Widget build(BuildContext context) {
    return Image.network(
        imageUrl,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress
                  .expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Text('Image could not be loaded.');
          },
    );
  }
}