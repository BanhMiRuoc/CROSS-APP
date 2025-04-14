import 'package:flutter/material.dart';
import 'AddNoteScreen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  // Sample list of notes (each note is represented as a Map).
  final List<Map<String, String>> notes = [
    {
      'title': 'Việt Nam khởi đầu tốt nhất lịch sử dự U20 châu Á',
      'content': 'Lần đầu trong lịch sử 64 năm của giải U20 châu Á...'
    },
    {
      'title': 'Truyền thông Indonesia khen U20 Việt Nam phi thường',
      'content': 'Nhiều báo, đài Indonesia ngạc nhiên...'
    },
    {
      'title': 'Hai nghi can cướp ngân hàng ở Sài Gòn bị bắt',
      'content': 'Ngày 5/3, lực lượng chức năng đã vây bắt thành công...'
    },
    {
      'title': 'Phạt dưới 250.000 đồng, CSGT không ghi hình',
      'content': 'Một số quy định mới liên quan đến xử phạt vi phạm...'
    },
    {
      'title': 'Cắt giảm nhân sự đang là bài toán nan giải',
      'content': 'Nhiều ngành nghề bị ảnh hưởng bởi kinh tế suy giảm...'
    },
    {
      'title': 'Ngành vận tải biển đứng trước thách thức lớn',
      'content': 'Thị trường cạnh tranh gay gắt, nhiều hãng phải cắt giảm...'
    },
  ];

  // Variable to track the display mode: false = ListView, true = GridView.
  bool _isGridView = false;

  /// Navigate to AddNoteScreen to add a new note.
  Future<void> _navigateToAddNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNoteScreen()),
    );
    if (result != null && result is Map<String, String>) {
      setState(() {
        notes.add(result);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note added successfully')),
      );
    }
  }

  /// Navigate to AddNoteScreen in order to edit an existing note.
  /// [index] is the position of the note in the list.
  Future<void> _navigateToEditNote(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNoteScreen(note: notes[index])),
    );
    // If changes were made, update the note and show snackbar.
    if (result != null && result is Map<String, String>) {
      setState(() {
        notes[index] = result;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note updated successfully')),
      );
    }
  }

  /// Build a ListView item for a note.
  Widget _buildListItem(Map<String, String> note, int index) {
    return InkWell(
      onTap: () => _navigateToEditNote(index),
      child: ListTile(
        leading: const Icon(Icons.event_note, color: Colors.black),
        title: Text(
          note['title'] ?? '',
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          note['content'] ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  /// Build a GridView item for a note.
  Widget _buildGridItem(Map<String, String> note, int index) {
    return InkWell(
      onTap: () => _navigateToEditNote(index),
      child: Card(
        color: Colors.yellow,
        margin: const EdgeInsets.all(8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title: red color, bold.
              Text(
                note['title'] ?? '',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Content: black text.
              Expanded(
                child: Text(
                  note['content'] ?? '',
                  style: const TextStyle(color: Colors.black),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Choose display mode: ListView.separated or GridView.builder.
    final bodyWidget = _isGridView
        ? GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns.
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) =>
          _buildGridItem(notes[index], index),
    )
        : ListView.separated(
      itemCount: notes.length,
      itemBuilder: (context, index) => _buildListItem(notes[index], index),
      separatorBuilder: (context, index) => Divider(
        color: Colors.black12, // A faint dividing line.
        thickness: 1,
        height: 1,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white, // Overall background is white.
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Note Management'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: bodyWidget,
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
