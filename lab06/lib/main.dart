import 'package:flutter/material.dart';
import 'NoteListScreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(totalScreen: 12),
    ),
  );
}

class MyApp extends StatelessWidget {
  final int totalScreen;   // Tổng số màn hình tối đa
  final int currentScreen; // Màn hình hiện tại (tính từ 1)

  const MyApp({
    Key? key,
    required this.totalScreen,
    this.currentScreen = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WillPopScope để xử lý nút back của thiết bị (Android) hoặc navigation back (iOS).
    return WillPopScope(
      onWillPop: () async {
        // Nếu đang ở màn hình > 1, chúng ta pop (trở về màn hình trước)
        if (currentScreen > 1) {
          Navigator.pop(context);
          return false; // false: Flutter sẽ không tự pop thêm
        }
        // Ở màn hình 1 thì cho thoát hẳn app (true)
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Multi-Screen App'),
          centerTitle: true, // Canh giữa để giống ảnh mẫu
        ),
        body: _buildBody(context),
        floatingActionButton: _buildFab(context),
      ),
    );
  }

  /// Hàm build body:
  /// - Ở màn hình 1: chỉ hiển thị số "1" lớn ở giữa.
  /// - Từ màn hình 2 trở đi: hiển thị số lớn ở trên cùng + lưới (grid) nút.
  Widget _buildBody(BuildContext context) {
    if (currentScreen == 1) {
      // Màn hình đầu tiên (Step 1)
      return Center(
        child: Text(
          '$currentScreen',
          style: const TextStyle(fontSize: 100, color: Colors.blue),
        ),
      );
    } else {
      // Từ màn hình 2 trở đi
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            '$currentScreen',
            style: const TextStyle(fontSize: 80, color: Colors.blue),
          ),
          const SizedBox(height: 20),
          // Grid các nút, số cột tùy chỉnh để gần giống hình
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,      // Chỉnh 3 cột cho gần giống hình
              crossAxisSpacing: 8,    // Khoảng cách giữa các cột
              mainAxisSpacing: 8,     // Khoảng cách giữa các hàng
              padding: const EdgeInsets.all(16),
              children: List.generate(totalScreen, (index) {
                final screenNumber = index + 1;
                final isJumpAllowed = screenNumber < currentScreen;
               return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: isJumpAllowed ? Colors.white : Colors.grey[700], backgroundColor: isJumpAllowed ? Colors.blue : Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Nút hình chữ nhật
                    ),
                  ),
                  onPressed: isJumpAllowed
                      ? () {
                    final stepsToPop = currentScreen - screenNumber;
                    for (int i = 0; i < stepsToPop; i++) {
                      Navigator.pop(context);
                    }
                  }
                      : null,
                  child: Text('$screenNumber'),
                );

              }),
            ),
          ),
        ],
      );
    }
  }

  /// Nút FAB (floating action button) chỉ hiển thị nếu chưa ở màn hình cuối
  /// Khi bấm, push MyApp(currentScreen+1) để sang màn hình kế
  Widget? _buildFab(BuildContext context) {
    if (currentScreen < totalScreen) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyApp(
                totalScreen: totalScreen,
                currentScreen: currentScreen + 1,
              ),
            ),
          );
        },
        child: const Icon(Icons.navigate_next),
      );
    } else {
      // Ở màn hình cuối thì ẩn nút
      return null;
    }
  }
}
