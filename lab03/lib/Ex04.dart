import 'package:flutter/material.dart';
import 'products.dart'; // Import danh sách sản phẩm

class Ex04 extends StatefulWidget {
  const Ex04({Key? key}) : super(key: key);

  @override
  _Ex04State createState() => _Ex04State();
}

class _Ex04State extends State<Ex04> {
  final GlobalKey<_Ex04State> _gridKey = GlobalKey();
  Set<int> selectedItems = {}; // Lưu trạng thái chọn

  void _toggleSelection(int index) {
    setState(() {
      if (selectedItems.contains(index)) {
        selectedItems.remove(index);
      } else {
        selectedItems.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GridView Selectable")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          key: _gridKey,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _toggleSelection(index),
              onLongPress: () => _toggleSelection(index),
              child: ProductCard(
                product: products[index],
                isSelected: selectedItems.contains(index),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isSelected;

  ProductCard({required this.product, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      color: isSelected ? Colors.grey[400] : Colors.white, // Đổi màu khi chọn
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product["Product Name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${product["Price"]}\$",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          if (isSelected) // Nếu được chọn, hiển thị biểu tượng dấu tick
            Positioned(
              top: 8,
              right: 8,
              child: Icon(Icons.check_circle, color: Colors.white),
            ),
        ],
      ),
    );
  }
}