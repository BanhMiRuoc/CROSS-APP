import 'package:flutter/material.dart';

class ex01 extends StatefulWidget {
  const ex01({Key? key}) : super(key: key);

  @override
  State<ex01> createState() => _ex01();
}

class _ex01 extends State<ex01> {
  // Controller để lấy nội dung nhập từ TextField
  final TextEditingController _controller = TextEditingController();
  // FocusNode để focus lại TextField sau khi thêm vào danh sách
  final FocusNode _focusNode = FocusNode();
  // Danh sách chứa các item
  final List<String> _items = [];

  // Hàm thêm item vào List
  void _addItem() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      // Nếu ô TextField trống, hiển thị Snackbar báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bạn chưa nhập nội dung!'),
        ),
      );
      return;
    }

    // Nếu hợp lệ, thêm vào List
    setState(() {
      _items.add(text);
      // Xóa TextField
      _controller.clear();
    });

    // Focus lại TextField để nhập tiếp
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                labelText: 'Nhập nội dung',
                hintText: 'Hãy nhập một tin nhắn...',
              ),
              // Người dùng có thể nhấn Enter để thêm
              onSubmitted: (value) => _addItem(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addItem,
              child: const Text('Thêm vào danh sách'),

            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
