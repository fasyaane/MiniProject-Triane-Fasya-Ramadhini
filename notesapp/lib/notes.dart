import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class Note {
  final String title;
  final String content;

  Note({required this.title, required this.content});
}

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final List<Note> notes = [];

  void _addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  void _createNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateNoteScreen()),
    );

    if (result != null && result is Note) {
      _addNote(result);
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8ABCD7),
        title: Text('Catatan'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut(context);
            },
          ),
        ],
      ),
      body: notes.isEmpty
          ? Center(child: Text('Belum ada catatan.'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(notes[index].title),
                        subtitle: Text(notes[index].content),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNote();
        },
        backgroundColor: Color(0xFF8ABCD7),
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreateNoteScreen extends StatefulWidget {
  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8ABCD7),
        title: Text('Buat Catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Judul',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Isi Catatan',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;
                if (title.isNotEmpty && content.isNotEmpty) {
                  final newNote = Note(
                    title: title,
                    content: content,
                  );
                  Navigator.pop(context, newNote);
                }
              },
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF8ABCD7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void main() {
    runApp(MaterialApp(
      home: NoteListScreen(),
    ));
  }
}
