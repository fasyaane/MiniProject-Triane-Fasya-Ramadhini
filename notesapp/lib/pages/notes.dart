import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notesapp/pages/login.dart';
import '../notes_model.dart';
import 'package:notesapp/data_source/firebase_data_source.dart';

void main() {
  runApp(MaterialApp(
    home: NoteListScreen(),
  ));
}

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final FirebaseDataSource _dataSource = FirebaseDataSource();
  List<Note> notes = [];

  void _editNote(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(  
        builder: (context) => CreateNoteScreen(existingNote: notes[index]),
      ),
    );

    if (result != null && result is Note) {
      try {
        await _dataSource.updateNote(result.id, result.title, result.content);
        setState(() {
          notes[index] = result;
        });
      } catch (e) {
        print("Error updating note: $e");
      }
    }
  }

  void _deleteNote(int index) async {
    bool hapus = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hapus Catatan"),
          content: const Text("Apakah Anda yakin ingin menghapus catatan ini?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Tidak"),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Mengembalikan false ketika memilih "Tidak"
              },
            ),
            TextButton(
              child: const Text("Ya"),
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Mengembalikan true ketika memilih "Ya"
              },
            ),
          ],
        );
      },
    );

    if (hapus == true) {
      try {
        await _dataSource.deleteNote(notes[index].id);
      } catch (e) {
        print("Error deleting note: $e");
      }
    }
  }

  void _createNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateNoteScreen()),
    );

    if (result != null && result is Note) {
      try {
        String newId = _dataSource.newId();
        final newNote = Note(
          id: newId,
          title: result.title,
          content: result.content,
        );
        await _dataSource.addNote(newNote.id, newNote.title, newNote.content);
      } catch (e) {
        print("Error adding note: $e");
      }
    }
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8ABCD7),
        title: Text('${_dataSource.currentUser.email} Catatan'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _signOut();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Note>>(
        stream: _dataSource.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          notes = snapshot.data ?? [];

          return notes.isEmpty
              ? const Center(child: Text('Tidak ada catatan.'))
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
                            onTap: () {
                              _editNote(index);
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteNote(index);
                              },
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNote();
        },
        backgroundColor: const Color(0xFF8ABCD7),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateNoteScreen extends StatefulWidget {
  final Note? existingNote;

  CreateNoteScreen({this.existingNote});

  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final _idController = TextEditingController();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    if (widget.existingNote != null) {
      _idController.text = widget.existingNote!.id;
      _titleController.text = widget.existingNote!.title;
      _contentController.text = widget.existingNote!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8ABCD7),
        title: const Text('Buat Catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Isi Catatan',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final id = _idController.text;
                final title = _titleController.text;
                final content = _contentController.text;
                if (title.isNotEmpty && content.isNotEmpty) {
                  final newNote = Note(
                    id: id,
                    title: title,
                    content: content,
                  );
                  Navigator.pop(context, newNote);
                }
              },
              child: const Text('Simpan'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF8ABCD7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
