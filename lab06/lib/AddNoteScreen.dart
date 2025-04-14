// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  /// If [note] is null, this screen is used for creating a new note.
  /// If [note] is provided, it is used for editing the existing note.
  final Map<String, String>? note;
  const AddNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String _initialTitle;
  late String _initialContent;

  @override
  void initState() {
    super.initState();

    // Initialize with existing note data if available, else empty for new note.
    _initialTitle = widget.note != null ? (widget.note!['title'] ?? '') : '';
    _initialContent = widget.note != null ? (widget.note!['content'] ?? '') : '';

    _titleController = TextEditingController(text: _initialTitle);
    _contentController = TextEditingController(text: _initialContent);
  }

  void _saveNote() {
    final currentTitle = _titleController.text.trim();
    final currentContent = _contentController.text.trim();

    // If no changes were made, simply pop without showing a snackbar.
    if (currentTitle == _initialTitle && currentContent == _initialContent) {
      Navigator.pop(context);
      return;
    }

    // Validate input: both fields must be non-empty.
    if (currentTitle.isEmpty || currentContent.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Both title and content are required')),
      );
      return;
    }

    // Create the note data.
    final noteData = {
      'title': currentTitle,
      'content': currentContent,
    };

    // Determine message based on whether we're editing or adding.
    final bool isEditing = widget.note != null;
    final String message = isEditing
        ? 'Note updated successfully'
        : 'Note added successfully';

    // Show the snackbar.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

    // After a short delay (so the user sees the snackbar), pop with the note data.
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context, noteData);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine UI texts based on whether we're editing or adding.
    final bool isEditing = widget.note != null;
    final String appBarTitle = isEditing ? 'Edit Note' : 'Create New Note';
    final String buttonText = isEditing ? 'Update Note' : 'Save Note';

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Title TextFormField.
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            // Content TextFormField.
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text(buttonText),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
