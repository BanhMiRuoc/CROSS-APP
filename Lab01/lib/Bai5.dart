import 'package:flutter/material.dart';

class Bai5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserInteraction(),
    );
  }
}

class UserInteraction extends StatefulWidget {
  @override
  _UserInteractionState createState() => _UserInteractionState();
}

class _UserInteractionState extends State<UserInteraction> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<Widget> _messages = [];

  bool _isBold = false;
  bool _isColored = false;
  bool _isLarge = false;

  void _saveMessage() {
    String inputText = _controller.text.trim();

    if (inputText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Message cannot be empty!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _messages.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("-> ", style: TextStyle(fontSize: 20)),
            Expanded(
              child: Text(
                inputText,
                style: TextStyle(
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: _isLarge ? 24 : 18,
                  color: _isColored ? Colors.blue : Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
      _controller.clear();
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Interaction',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Type a message',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _saveMessage(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSwitch("Bold", _isBold, (val) => setState(() => _isBold = val)),
                _buildSwitch("Blue", _isColored, (val) => setState(() => _isColored = val)),
                _buildSwitch("Large", _isLarge, (val) => setState(() => _isLarge = val)),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveMessage,
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _messages
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Text(title),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}