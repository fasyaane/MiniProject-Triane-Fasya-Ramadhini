import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notesapp/notes_model.dart';
import 'package:notesapp/main.dart';

class FirebaseDataSource {
  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not Authentication exception');
    return user;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  String newId() {
    return firestore.collection('notes').doc().id;
  }

  Future<void> addNote(String id, String title, String content) async {
    CollectionReference notes = firestore.collection('notes');
    final userId =
        currentUser.uid; // Dapatkan ID pengguna yang telah diautentikasi

    await notes.doc(userId).collection('user_notes').doc(id).set({
      'title': title,
      'content': content,
    });
  }

  Future<void> updateNote(String noteId, String title, String content) async {
    CollectionReference notes = firestore.collection('notes');
    final userId =
        currentUser.uid; // Dapatkan ID pengguna yang telah diautentikasi

    await notes.doc(userId).collection('user_notes').doc(noteId).update({
      'title': title,
      'content': content,
    });
  }

  Future<void> deleteNote(String noteId) async {
    CollectionReference notes = firestore.collection('notes');
    final userId =
        currentUser.uid; // Dapatkan ID pengguna yang telah diautentikasi

    await notes.doc(userId).collection('user_notes').doc(noteId).delete();
  }

  Stream<List<Note>> getNotesStream() {
    final userId = currentUser.uid;
    Stream<QuerySnapshot> snapshots = firestore
        .collection('notes')
        .doc(userId)
        .collection('user_notes')
        .snapshots();
    return snapshots.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Note(
          id: doc.id,
          title: doc['title'],
          content: doc['content'],
        );
      }).toList();
    });
  }
}
